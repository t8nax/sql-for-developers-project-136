CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
    is_deleted BOOLEAN NOT NULL
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    video_link VARCHAR(255),
    position INT NOT NULL
    created_at TIMESTAMP NOT NULL, 
    updated_at TIMESTAMP NOT NULL,
    course_id BIGINT NOT NULL REFERENCES courses(id),
    is_deleted BOOLEAN NOT NULL
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    is_deleted BOOLEAN NOT NULL
);

CREATE TABLE courses_modules (
    course_id BIGINT,
    module_id BIGINT,
    PRIMARY KEY(course_id, module_id)
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    price DECIMAL NOT NULL,
    type VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE modules_programs (
    module_id BIGINT,
    program_id BIGINT
    PRIMARY KEY(module_id, program_id)
);