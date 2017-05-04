class RefereeRelationCreateContext < BaseContext
  before_perform :find_person_type
  before_perform :find_person, unless: :is_judge?
  before_perform :find_judge_person, if: :is_judge?
  before_perform :check_scoped
  before_perform :build_data

  def initialize(referee)
    @referee = referee
    @story = @referee.story
    @court = @story.court
  end

  def perform(person_name)
    @person_name = person_name
    run_callbacks :perform do
      if @referee_relation.save
        @referee_relation
      else
        add_error(:data_create_fail, @referee_relation.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def find_person_type
    @person_type = 'Party' if @referee.party_names.include?(@person_name)
    @person_type = 'Lawyer' if @referee.lawyer_names.include?(@person_name)
    @person_type = 'Judge' if @referee.judges_names.include?(@person_name)
    @person_type = 'Prosecutor' if @referee.prosecutor_names.include?(@person_name)
    add_error(:story_without_people_name) unless @person_type
  end

  def is_judge?
    @person_type == 'Judge'
  end

  def find_person
    class_object = Object.const_get(@person_type)
    @scoped = class_object.where(name: @person_name)
    @person = @scoped.first
  end

  def find_judge_person
    branches = @court.branches.current.where('chamber_name LIKE ? ', "%#{@story.story_type}%")
    @scoped = branches.map { |a| a.judge if a.judge.name == @person_name }.compact.uniq
    @person = @scoped.first
  end

  def check_scoped
    add_error(:people_name_error) unless @scoped.count == 1
  end

  def build_data
    @referee_relation = @referee.class == Verdict ? init_verdict_relation : init_rule_relation
  end

  def init_verdict_relation
    @referee.verdict_relations.find_or_initialize_by(person: @person)
  end

  def init_rule_relation
    @referee.rule_relations.find_or_initialize_by(person: @person)
  end

end
