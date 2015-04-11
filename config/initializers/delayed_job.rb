module Delayed
  class Job < ActiveRecord::Base
    belongs_to :user

    default_scope { includes(:user) }
  end
end

CreatePageFromFileJob = Struct.new(:node_id, :path) do
  def perform
    Page.create node_id: node_id, image: File.open(path)
  end
end

RakeJob = Struct.new(:name) do
  def perform
    `rake #{name}`
  end
end

