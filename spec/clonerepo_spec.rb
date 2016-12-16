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
    @repository.flog.must_be_instance_of Array
  end

  it 'HAPPY: should contain flay' do
    @repository.flay.must_be_instance_of Float
  end
end
