# frozen_string_literal: true

user = User.create(email: 'admin@devsinc.com', password: 'taha1234', username: 'Admin')
post = user.posts.new(body: 'first post by seed')
post.images.attach(io: File.open('app/assets/images/dummy.jpg'), filename: 'some-image.jpg', content_type: 'image/jpg')
post.save!
comment = post.comments.new(user_id: user.id, body: 'First comment by seed')
comment.save
