# EduApp

To start it up:

```
bundle install
bundle exec rails server
```

# Sidekiq

Gotta run Sidekiq to do all of the background stuff.

```
bundle exec sidekiq
```

# Poxa

Hmm.

# Filepicker

To run the instance locally,

Edit ```filepicker/server.js```

At the bottom, you'll want this:

```javascript
module.exports = {
  start: start // note this is "start", not "startSSL"
};
```

Then

```
cd filepicker
npm install
STUDENT_PORTAL_URL=http://localhost:3000 LOCAL_FILEPICKER_URL=http://localhost:8000 npm start
```

When you start your Rails app, make sure to do it like this:

```
LOCAL_FILEPICKER_URL=http://localhost:8000 bundle exec rails server
```
