class Scrap::ImportBranchContext < BaseContext
  # TODO 更新部分還要確認, 目前就先拆開
  before_perform  :find_branch
  before_perform  :bulid_branch

  def initialize(judge)
    @judge = judge
    @court = judge.court
  end

  def perform(chamber_name, branch_name)
    @chamber_name = chamber_name
    @branch_name = branch_name
    run_callbacks :perform do
      return add_error(:data_create_fail, "branch find_or_create fail") unless @branch.save
      @branch
    end
  end

  def find_branch
    @branch = Branch.current.find_by(court: @court, judge: @judge, chamber_name: @chamber_name, name: @branch_name )
  end

  def bulid_branch
    @branch = Branch.new(court: @court, judge: @judge, chamber_name: @chamber_name, name: @branch_name ) unless @branch
  end
end
