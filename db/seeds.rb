# frozen_string_literal: true

user = User.create(email: 'taha.babar.admin@devsinc.com', password: 'taha1234', username: 'Admin')
post = user.posts.new(body: 'first post by seed')
post.image.attach("dummy.jpg")
post.save
comment = post.comments.create(user_id: user.id, body: "First comment by seed")
