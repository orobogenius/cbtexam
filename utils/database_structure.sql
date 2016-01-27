CREATE DATABASE cbtExam;

USE cbtExam;

/* Tables */

CREATE TABLE cbtUsers (
  userID int(10) NOT NULL,
  userPassword varchar(225) NOT NULL,
  userEmail varchar(225),
  userFirstname varchar(225),
  userLastname varchar(225),
  userLevel Smallint(3) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (userID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtQuestions (
  questionID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionDescription Text NOT NULL,
  testID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (questionID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtAnswers (
  answerID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionID Bigint UNSIGNED NOT NULL,
  answerDescription Text NOT NULL,
  answerIsRight Bool NOT NULL DEFAULT '0',
  PRIMARY KEY (answerID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtScores (
  scoreID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  userID int(10) NOT NULL,
  testID Bigint UNSIGNED NOT NULL,
  userScore Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (scoreID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtTests (
  testID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  testName varchar(225) NOT NULL,
  testDescription Text NOT NULL,
  testDuration Smallint(10) UNSIGNED NOT NULL DEFAULT 0,
  testCreatedBy int(10) NOT NULL,
  testMinScore Bigint UNSIGNED NOT NULL DEFAULT 0,
  testMaxScore Bigint UNSIGNED NOT NULL DEFAULT 0,
  testStatus Bool NOT NULL DEFAULT '0',
  testStarted varchar(10) NULL,
  Primary Key (testID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtTestsUsers (
  testUserID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  testID Bigint UNSIGNED NOT NULL,
  userID int(10) NOT NULL,
  Primary Key (testUserID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtLogSTDAnswers (
  answerLogID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  userID int(10) NOT NULL,
  questionID Bigint UNSIGNED NOT NULL,
  userAnswerID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (answerLogID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtQuestionTypeA (
  typeID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (typeID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtQuestionTypeB (
  typeID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (typeID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtQuestionTypeC (
  typeID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (typeID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtQuestionTypeD (
  typeID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  questionID Bigint UNSIGNED NOT NULL,
  PRIMARY KEY (typeID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtGroups (
  groupID Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
	groupName varchar(255) NOT NULL,
	UNIQUE (groupName),
 Primary Key (groupID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtUserGroup (
  userID int(10) NOT NULL,
	groupID Bigint UNSIGNED NOT NULL,
 Primary Key (userID, groupID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtTestGroup (
  testID Bigint UNSIGNED NOT NULL,
  groupID Bigint UNSIGNED NOT NULL,
  activeInGroup Bool NOT NULL DEFAULT '0',
  Primary Key (testID, groupID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE cbtTestsQuestions (
  testQuestionID BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  testID BIGINT(10) UNSIGNED NOT NULL,
  questionID BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (testQuestionID)
) ENGINE = InnoDB
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

/* Indexes */

ALTER TABLE cbtAnswers ADD INDEX i_questionID (questionID);
ALTER TABLE cbtLogSTDAnswers ADD INDEX i_userID (userID);

/*  Foreign Keys */

ALTER TABLE cbtQuestions ADD Foreign Key (testID) references cbtTests (testID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtAnswers ADD Foreign Key (questionID) references cbtQuestions (questionID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtScores ADD Foreign Key (userID) references cbtUsers (userID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtScores ADD Foreign Key (testID) references cbtTests (testID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtLogSTDAnswers ADD Foreign Key (userID) references cbtUsers (userID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtLogSTDAnswers ADD Foreign Key (questionID) references cbtQuestions (questionID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtLogSTDAnswers ADD Foreign Key (userAnswerID) references cbtAnswers (answerID) ON DELETE cascade on UPDATE no action;
ALTER TABLE cbtTests ADD Foreign Key (testCreatedBy) references cbtUsers (userID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtTestsUsers ADD Foreign Key (testID) references cbtTests (testID) ON DELETE cascade ON UPDATE restrict;
ALTER TABLE cbtTestsUsers ADD Foreign Key (userID) references cbtUsers (userID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtUserGroup ADD Foreign Key (userID) references cbtUsers (userID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtTestGroup ADD Foreign Key (testID) references cbtTests (testID) ON DELETE cascade ON UPDATE no action;
ALTER TABLE cbtTestsQuestions ADD Foreign Key (testID) references cbtTests (testID) ON DELETE cascade on UPDATE no action;
ALTER TABLE cbtTestsQuestions ADD Foreign Key (questionID) references cbtQuestions (questionID) ON DELETE cascade on UPDATE no action;
