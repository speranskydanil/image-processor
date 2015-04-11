class Right
  def self.instances
    @@instances
  end

  def initialize(id, group, name, abilities)
    (@@instances ||= []) << self

    @id = id
    @group = group
    @name = name
    @abilities = abilities
  end

  attr_reader :id, :group, :name, :abilities
end

Right.new  1,  'role', 'role_read',                   [[Role,            :read]]
Right.new  2,  'role', 'role_create',                 [[Role,            :create]]
Right.new  3,  'role', 'role_update',                 [[Role,            :update]]
Right.new  4,  'role', 'role_destroy',                [[Role,            :destroy]]
Right.new  5,  'user', 'user_read',                   [[User,            :read]]
Right.new  6,  'user', 'user_create_by_admin',        [[User,           [:new,
                                                                         :create_by_admin]]]
Right.new  7,  'user', 'user_update',                 [[User,            :update]]
Right.new  8,  'user', 'user_destroy',                [[User,            :destroy]]
Right.new  9,  'node', 'node_create',                 [[Node,            :create]]
Right.new 10,  'node', 'node_update',                 [[Node,            :update]]
Right.new 11,  'node', 'node_destroy',                [[Node,            :destroy]]
Right.new 12,  'node', 'node_upload_pages',           [[Node,            :upload_pages]]
Right.new 13,  'node', 'node_destroy_children',       [[Node,            :destroy_children]]
Right.new 14,  'node', 'node_destroy_pages',          [[Node,            :destroy_pages]]
Right.new 15,  'node', 'node_update_pages_positions', [[Node,            :update_pages_positions]]
Right.new 16,  'node', 'node_generate_archive',       [[Node,           [:generate_archive,
                                                                         :remove_archive]]]
Right.new 17,  'node', 'node_cancel',                 [[Node,            :cancel]]
Right.new 18,  'node', 'node_duplicate',              [[Node,            :duplicate]]
Right.new 19,  'page', 'page_create',                 [[Page,            :create]]
Right.new 20,  'page', 'page_destroy',                [[Page,            :destroy]]
Right.new 21,  'page', 'page_process',                [[Page,           [:process_form,
                                                                         :process_act]]]
Right.new 22,  'page', 'page_cancel',                 [[Page,            :cancel]]
Right.new 23,  'page', 'page_duplicate',              [[Page,            :duplicate]]
Right.new 24,  'page', 'page_insert',                 [[Page,            :insert]]
Right.new 25, 'other', 'common_statistics',           [[:common,        [:statistics,
                                                                         :disk_usage_for_images]]]
Right.new 26, 'other', 'create_mail',                 [[:common,        [:new_mail_to_admin,
                                                                         :create_mail_to_admin]]]
Right.new 28, 'other', 'update_counters',             [[:common,         :update_counters]]
Right.new 27, 'other', 'jobs',                        [[:job,           [:index,
                                                                         :update,
                                                                         :destroy,
                                                                         :destroy_all]]]

