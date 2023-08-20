-- 創建資料庫
CREATE DATABASE social_media;
USE social_media;

-- 創建使用者資料表
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(255),
    Email VARCHAR(255),
    Password VARCHAR(255),
    CoverImage VARCHAR(255),
    Biography TEXT
);

-- 創建發文資料表
CREATE TABLE Post (
    PostID INT PRIMARY KEY,
    UserID INT,
    Content TEXT,
    Image VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- 創建留言資料表
CREATE TABLE Comment (
    CommentID INT PRIMARY KEY,
    UserID INT,
    PostID INT,
    Content TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

-- 創建存儲過程
DELIMITER //
CREATE PROCEDURE CreatePostWithComment(
    IN p_userName VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_coverImage VARCHAR(255),
    IN p_biography TEXT,
    IN p_content TEXT,
    IN p_image VARCHAR(255),
    IN p_commentContent TEXT
)
BEGIN
    DECLARE v_userID INT;
    DECLARE v_postID INT;
    DECLARE v_commentID INT;

    -- 開始 Transaction
    START TRANSACTION;

    -- 插入使用者資料
    INSERT INTO User (UserName, Email, Password, CoverImage, Biography)
    VALUES (p_userName, p_email, p_password, p_coverImage, p_biography);
    SET v_userID = LAST_INSERT_ID();

    -- 插入發文資料
    INSERT INTO Post (UserID, Content, Image)
    VALUES (v_userID, p_content, p_image);
    SET v_postID = LAST_INSERT_ID();

    -- 插入留言資料
    INSERT INTO Comment (UserID, PostID, Content)
    VALUES (v_userID, v_postID, p_commentContent);
    SET v_commentID = LAST_INSERT_ID();

    -- 提交 Transaction
    COMMIT;
END;
//
DELIMITER ;

-- 執行存儲過程
CALL CreatePostWithComment(
    'John Doe', 
    'john@example.com', 
    'hashed_password', 
    'cover_image.jpg', 
    'A passionate writer.', 
    'Hello, world!', 
    'post_image.jpg', 
    'Nice post!'
);

