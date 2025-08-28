# Calendar Application

A modern, feature-rich calendar application built with Ruby on Rails 8, featuring event management, user authentication, real-time messaging, and email notifications.

## Features

### 🗓️ Event Management

- Create and manage calendar events with title, description, date, and time
- Smart time validation (end time must be after start time)
- User-specific event organization

### 👤 User Authentication

- Secure user registration and login system
- Password-protected accounts with bcrypt encryption
- User profile management

### 💬 Real-time Messaging

- Live chat functionality using Action Cable
- Message history and recent conversations
- Real-time updates across all connected users

### 📧 Email Notifications

- Automated event reminders via email
- Background job processing with Sidekiq
- Customizable email templates

### 🎨 Modern UI/UX

- Responsive design with Tailwind CSS
- Progressive Web App (PWA) support
- Stimulus.js for enhanced interactivity
- Turbo for fast page transitions

## Tech Stack

- **Backend**: Ruby on Rails 8.0.2
- **Database**: PostgreSQL
- **Frontend**: Stimulus.js, Turbo
- **Real-time**: Action Cable
- **Background Jobs**: Sidekiq
- **Email**: Letter Opener (development)
- **Authentication**: bcrypt
- **Template Engine**: HAML

## Prerequisites

- Ruby 3.0 or higher
- PostgreSQL
- Node.js (for asset compilation)
- Redis (for Sidekiq background jobs)
