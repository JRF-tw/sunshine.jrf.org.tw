class VerdictRelationCreateContext < BaseContext
  before_perform :find_person_type
  before_perform :find_person, unless: :is_judge?
  before_perform :find_judge_person, if: :is_judge?
  before_perform :check_scoped
  before_perform :build_data

  def initialize(verdict)
    @verdict = verdict
    @story = @verdict.story
    @court = @story.court
  end

  def perform(person_name)
    @person_name = person_name
    run_callbacks :perform do
      if @verdict_relation.save
        @verdict_relation
      else
        add_error(:data_create_fail, @judge.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def find_person_type
    @person_type = "Party" if @verdict.party_names.include?(@person_name)
    @person_type = "Lawyer" if @verdict.lawyer_names.include?(@person_name)
    @person_type = "Judge" if @verdict.judges_names.include?(@person_name)
    # @person_type = "Prosecutor" if @verdict.prosecutor_names.include?(@person_name)
    add_error(:data_create_fail, "案件內沒有該人名紀錄") unless @person_type
  end

  def is_judge?
    @person_type == "Judge"
  end

  def find_person
    class_object = Object.const_get(@person_type)
    @scoped = class_object.where(name: @person_name)
    @person = @scoped.first
  end

  def find_judge_person
    branches = @court.branches.current.where("chamber_name LIKE ? ", "%#{@story.story_type}%")
    @scoped = branches.map { |a| a.judge if a.judge.name == @person_name }.compact.uniq
    @person = @scoped.first
  end

  def check_scoped
    add_error(:data_create_fail, "取得 多位或沒有 相同姓名的人") unless @scoped.count == 1
  end

  def build_data
    @verdict_relation = @verdict.verdict_relations.new(person: @person, verdict: @verdict)
  end

end
