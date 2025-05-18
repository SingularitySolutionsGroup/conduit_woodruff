## 📊 Production Monitoring & Logging Setup

This app is configured for production deployment on **Heroku** with integrated monitoring and performance tools:

### 🔴 Sentry — Error Monitoring

- Automatically captures application exceptions
- DSN is stored as an environment variable:
  ```bash
  heroku config:set SENTRY_DSN=your_sentry_dsn
  ```

### 📜 Logtail — Structured Logging

- Sends Rails logs to Logtail for advanced search and visualization
- Token stored as:
  ```bash
  heroku config:set LOGTAIL_SOURCE_TOKEN=your_logtail_token
  ```

### ⚡ Skylight — Performance Profiling

- Provides insights into request/response bottlenecks
- Token stored as:
  ```bash
  heroku config:set SKYLIGHT_AUTHENTICATION=your_skylight_token
  ```

### ✅ Deployment on Heroku

1. Install Heroku CLI and log in  
2. Create and link your Heroku app:
   ```bash
   heroku create conduit-multitenant
   ```
3. Push to Heroku:
   ```bash
   git push heroku main
   heroku run rails db:migrate
   ```

4. Confirm app is live at:
   ```
   https://yourtenant.yourdomain.com
   ```
