class Story::RelationCreateContext < BaseContext
  before_perform :find_people_type
  before_perform :find_people
  before_perform :check_scoped
  before_perform :build_data

  def initialize(story)
    @story = story
  end

  def perform(people_name)
    @people_name = people_name
    run_callbacks :perform do
      if @story_relation.save
        @story_relation
      else
        add_error(:data_create_fail, @judge.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def find_people_type
    @people_type = 'Party' if @story.party_names.include?(@people_name)
    @people_type = 'Lawyer' if @story.lawyer_names.include?(@people_name)
    @people_type = 'Judge' if @story.judges_names.include?(@people_name)
    @people_type = "Prosecutor" if @story.prosecutor_names.include?(@people_name)
    add_error(:story_without_people_name) unless @people_type
  end

  def find_people
    class_object = Object.const_get(@people_type)
    @scoped = class_object.where(name: @people_name)
    @people = @scoped.first
  end

  def check_scoped
    add_error(:people_name_error) unless @scoped.count == 1
  end

  def build_data
    @story_relation = @story.story_relations.find_or_initialize_by(people: @people, story: @story)
  end

end
