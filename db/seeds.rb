role = Role.create name: 'admin', right_ids: Right.instances.map(&:id)
User.create email: 'admin@company.com', password: 'password', roles: [role]

NodeStatus.create name: 'just created'
NodeStatus.create name: 'uploading pages'
NodeStatus.create name: 'pages are uploaded'
NodeStatus.create name: 'processing pages'
NodeStatus.create name: 'pages are processed'
NodeStatus.create name: 'published'

Node.create name: 'Image Processor'

