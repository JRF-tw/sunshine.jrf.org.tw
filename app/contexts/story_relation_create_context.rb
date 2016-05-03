class StoryRelationCreateContext < BaseContext
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
    @people_type = "Defendant" if @story.defendant_names.include?(@people_name)
    @people_type = "Lawyer" if @story.lawyer_names.include?(@people_name)
    @people_type = "Judge" if @story.judges_names.include?(@people_name) || @story.main_judge.name == @people_name
    # @people_type = "Prosecutor" if @story.prosecutor_names.include?(@people_name)
    add_error(:data_create_fail, "案件內沒有該人名紀錄") unless @people_type
  end

  def find_people
    @scoped = eval("#{@people_type}.where(name: \"#{@people_name}\")")
    @people = @scoped.first
  end

  def check_scoped
    add_error(:data_create_fail, "取得 多位或沒有 相同姓名的人") unless @scoped.count == 1
  end

  def build_data
    @story_relation = @story.story_relations.new(people: @people, story: @story)
  end

end
