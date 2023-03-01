CREATE TABLE
    users (
        user_id VARCHAR(256) PRIMARY KEY,
        account VARCHAR(256) NOT NULL,
        password VARCHAR(256) NOT NULL,
        name VARCHAR(256) NOT NULL,
        type ENUM ('user', 'manager', 'owner') NOT NULL,
        email VARCHAR(256),
        level INT NOT NULL,
        score INT NOT NULL,
        bank_balance INT NOT NULL,
        status ENUM ('active', 'inactive', 'locked') NOT NULL,
        space_limit BIGINT NOT NULL,
        space_used BIGINT NOT NULL,
        space_available BIGINT NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        index(type),
        index(email)
    );

CREATE TABLE
    score_history (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        score INT NOT NULL,
        action VARCHAR(256) NOT NULL,
        created_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        index(user_id)
    );

CREATE TABLE
    resource_groups (
        group_id VARCHAR(256) PRIMARY KEY,
        owner_id VARCHAR(256) NOT NULL,
        group_name VARCHAR(256) NOT NULL,
        group_description VARCHAR(1024) NOT NULL,
        group_level INT NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES users(user_id),
        index(owner_id)
    );

CREATE TABLE
    resource_groups_members (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        user_name VARCHAR(256) NOT NULL,
        user_permission ENUM ('user', 'manager', 'owner'),
        group_id VARCHAR(256) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (group_id) REFERENCES resource_groups(group_id),
        FOREIGN KEY (user_id) REFERENCES users(user_id),
    );

CREATE TABLE
    buckets (
        bucket_id VARCHAR(256) PRIMARY KEY,
        bucket_name VARCHAR(256) NOT NULL,
        storage_class VARCHAR(256) NOT NULL,
        owner_id VARCHAR(256) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES users(user_id),
        index(owner_id)
    );

CREATE TABLE
    folders (
        folder_id VARCHAR(256) PRIMARY KEY,
        folder_name VARCHAR(256) NOT NULL,
        owner_id VARCHAR(256) NOT NULL,
        parent_bucket_id VARCHAR(256) NOT NULL,
        parent_folder_id VARCHAR(256),
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (parent_bucket_id) REFERENCES buckets(bucket_id),
        FOREIGN KEY (parent_folder_id) REFERENCES folders(folder_id),
        FOREIGN KEY (owner_id) REFERENCES users(user_id),
        index(parent_bucket_id),
        index(parent_folder_id),
        index(owner_id)
    );

CREATE TABLE
    objects (
        object_id VARCHAR(256) PRIMARY KEY,
        owner_id VARCHAR(256) NOT NULL,
        parent_folder_id VARCHAR(256),
        parent_bucket_id VARCHAR(256) NOT NULL,
        object_name VARCHAR(256) NOT NULL,
        object_size BIGINT NOT NULL,
        content_type VARCHAR(256) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (parent_folder_id) REFERENCES folders(folder_id),
        FOREIGN KEY (parent_bucket_id) REFERENCES buckets(bucket_id),
        FOREIGN KEY (owner_id) REFERENCES users(user_id),
        index(parent_folder_id),
        index(parent_bucket_id),
        index(owner_id)
    );

CREATE TABLE
    object_locations (
        id VARCHAR(256) PRIMARY KEY,
        object_id VARCHAR(256) NOT NULL,
        server_id VARCHAR(256) NOT NULL,
        path VARCHAR(256) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (object_id) REFERENCES objects(object_id),
        FOREIGN KEY (server_id) REFERENCES servers(server_id),
        index(object_id),
        index(server_id)
    );

CREATE TABLE
    servers (
        server_id VARCHAR(256) PRIMARY KEY,
        host_ip VARCHAR(256) NOT NULL,
        space_limit BIGINT NOT NULL,
        space_used BIGINT NOT NULL,
        space_available BIGINT NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL
    );

CREATE TABLE
    resource_permissions (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        group_id VARCHAR(256),
        resource_type VARCHAR(256) NOT NULL,
        resource_id VARCHAR(256) NOT NULL,
        read_permission BOOLEAN NOT NULL,
        write_permission BOOLEAN NOT NULL,
        is_delete BOOLEAN NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        FOREIGN KEY (group_id) REFERENCES resource_groups(group_id),
        index(user_id),
        index(group_id)
    );

create Table
    resource_history (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        resource_type VARCHAR(256) NOT NULL,
        resource_id VARCHAR(256) NOT NULL,
        resource_size BIGINT NOT NULL,
        action VARCHAR(256) ENUM(
            'upload',
            'download',
            'delete',
            'rename',
            'move',
            'copy',
            'share',
            'unshare',
        ) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        index(user_id)
    );

CREATE TABLE
    stock (
        stock_id VARCHAR(256) PRIMARY KEY,
        stock_name VARCHAR(256) NOT NULL,
        stock_value DECIMAL(10, 2) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        index(stock_name)
    );

CREATE TABLE
    user_stocks (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        stock_id VARCHAR(256) NOT NULL,
        stock_value DECIMAL(10, 2) NOT NULL,
        quantity INT NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        FOREIGN KEY (stock_id) REFERENCES stocks(stock_id),
        index(user_id),
        index(stock_id)
    );

CREATE TABLE
    user_transactions (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        stock_id VARCHAR(256) NOT NULL,
        transaction_type ENUM ('buy', 'sell') NOT NULL,
        transaction_value DECIMAL(10, 2) NOT NULL,
        quantity INT NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        FOREIGN KEY (stock_id) REFERENCES stocks(stock_id),
        index(user_id),
        index(stock_id)
    );

CREATE TABLE
    bank (
        id VARCHAR(256) PRIMARY KEY,
        user_id VARCHAR(256) NOT NULL,
        balance DECIMAL(10, 2) NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        index(user_id)
    );