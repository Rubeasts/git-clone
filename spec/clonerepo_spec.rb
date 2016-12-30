# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Github specifications' do
  before do
    GetCloneData::ClonedRepo.wipe
    @repository = GetCloneData::ClonedRepo.clone(git_url: HAPPY_GIT_URL)
    @sad_repository = GetCloneData::ClonedRepo.clone(git_url: SAD_GIT_URL)
  end

  it 'SAD: should return nil for sad repository' do
    @sad_repository.must_be_nil
  end

  it 'HAPPY: should not return nil for happy repository' do
    @repository.must_be_instance_of GetCloneData::ClonedRepo
  end

  it 'HAPPY: should contain flog' do
    flog = {
      total_score: 407.33109526582183,
      max_score: 142.57356872856903,
      average: 31.333161174293988
    }
    @repository.get_flog_scores.must_equal flog
  end

  it 'HAPPY: should contain flay' do
    @repository.get_flay_score.must_be_instance_of Float
  end

  it 'HAPPY: should contain rubocop summary' do
    summary = {
      offense_count: 578,
      target_file_count: 6,
      inspected_file_count: 6
    }
    @repository.get_rubocop_errors.must_equal summary
  end
end
