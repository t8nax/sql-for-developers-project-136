
DROP TABLE IF EXISTS blogs;
DROP TABLE IF EXISTS discussions;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS program_completions;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS course_modules;
DROP TABLE IF EXISTS program_modules;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS modules;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS teaching_groups;
DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS courses;

DROP TYPE IF EXISTS article_status;
DROP TYPE IF EXISTS user_role;
DROP TYPE IF EXISTS enrollment_status;
DROP TYPE IF EXISTS payment_status;
DROP TYPE IF EXISTS program_completion_status;

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    video_url VARCHAR(255),
    position INT,
    created_at TIMESTAMP, 
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES courses(id),
    deleted_at TIMESTAMP
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE course_modules (
    course_id BIGINT REFERENCES courses(id),
    module_id BIGINT REFERENCES modules(id),
    PRIMARY KEY(course_id, module_id)
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL NOT NULL,
    program_type VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE program_modules (
    module_id BIGINT REFERENCES modules(id),
    program_id BIGINT REFERENCES programs(id),
    PRIMARY KEY(module_id, program_id)
);

CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE user_role AS ENUM ('Student', 'Teacher', 'Admin');

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    teaching_group_id BIGINT REFERENCES teaching_groups(id),
    role user_role NOT NULL,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE enrollment_status AS ENUM ('active', 'penging', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    program_id BIGINT NOT NULL REFERENCES programs(id),
    status enrollment_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT NOT NULL REFERENCES enrollments(id),
    status payment_status NOT NULL,
    paid_at TIMESTAMP NOT NULL,
    amount DECIMAL NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE program_completion_status AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    program_id BIGINT NOT NULL REFERENCES programs(id),
    status program_completion_status NOT NULL,
    started_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    program_id BIGINT NOT NULL REFERENCES programs(id),
    url VARCHAR(1023) NOT NULL,
    issued_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT NOT NULL REFERENCES lessons(id),
    name TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT NOT NULL REFERENCES lessons(id),
    name TEXT NOT NULL,
    url VARCHAR(1023) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT NOT NULL REFERENCES lessons(id),
    user_id BIGINT NOT NULL REFERENCES users(id),
    text TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE article_status AS ENUM ('created', 'in moderation', 'published', 'archived');

CREATE TABLE blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    name TEXT NOT NULL,
    content TEXT NOT NULL,
    status article_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);