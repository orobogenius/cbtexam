use cbtexam;
INSERT INTO cbtGroups (groupName) VALUES ('default');
INSERT INTO cbtUsers (userID, userPassword, userLevel) VALUES ('12345', 'cbtadmin', 2);
INSERT INTO cbtUserGroup (userID, groupID) VALUES (12345, 1);
