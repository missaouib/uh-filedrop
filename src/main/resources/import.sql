
insert into message (MSG_ID, MSG_ENABLED, MSG_TYPE_ID, MSG_TEXT) values (1, 'Y', 1, 'Welcome to the University of Hawai''i FileDrop application.');
insert into message (MSG_ID, MSG_ENABLED, MSG_TYPE_ID, MSG_TEXT) values (2, 'Y', 1, 'University of Hawaii Information Technology Services resides in a state-of-the-art, six-story, 74,000-square-foot facility located on the Manoa campus.');
insert into message (MSG_ID, MSG_ENABLED, MSG_TYPE_ID, MSG_TEXT) values (3, 'Y', 1, 'The access to this system is restricted.<br/>If you believe you should have access, <br/> please send an email to <a href=''mailto:duckart@hawaii.edu''>duckart@hawaii.edu</a>.');
insert into message (MSG_ID, MSG_ENABLED, MSG_TYPE_ID, MSG_TEXT) values (4, 'N', 1, 'For Future Use.');
insert into message (MSG_ID, MSG_ENABLED, MSG_TYPE_ID, MSG_TEXT) values (5, 'Y', 1, 'Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.');

-- Campus codes and names.
insert into campus (id, code, actual, description) values (1,  'HA', 'Y', 'Hawaii Community College');
insert into campus (id, code, actual, description) values (2,  'HI', 'Y', 'UH Hilo');
insert into campus (id, code, actual, description) values (3,  'HO', 'Y', 'Honolulu Community College');
insert into campus (id, code, actual, description) values (4,  'KA', 'Y', 'Kapiolani Community College');
insert into campus (id, code, actual, description) values (5,  'KU', 'Y', 'Kauai Community College');
insert into campus (id, code, actual, description) values (6,  'LE', 'Y', 'Leeward Community College');
insert into campus (id, code, actual, description) values (7,  'MA', 'Y', 'UH Manoa');
insert into campus (id, code, actual, description) values (8,  'MU', 'Y', 'UH Maui College');
insert into campus (id, code, actual, description) values (9,  'WI', 'Y', 'Windward Community College');
insert into campus (id, code, actual, description) values (10, 'WO', 'Y', 'UH West Oahu');
insert into campus (id, code, actual, description) values (11, 'SW', 'N', 'UH System');

-- Campus offices.
insert into office (id, campus_id, sort_id, description) values (1,   1, 1,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (2,   2, 7,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (3,   3, 2,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (4,   4, 3,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (5,   5, 4,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (6,   6, 5,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (7,   7, 8,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (8,   8, 9,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (9,   9, 6,  'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (10, 10, 10, 'Chancellors Office');
insert into office (id, campus_id, sort_id, description) values (11, 11, 11, 'Information Technology Services');
insert into office (id, campus_id, sort_id, description) values (12, 11, 12, 'Vice President for Community Colleges');

insert into role (id, role, security_role, description) values (1,  'APPLICANT',      'APPLICANT',     'Applicant');
insert into role (id, role, security_role, description) values (3,  'COORDINATOR',    'COORDINATOR',   'Coordinator');
insert into role (id, role, security_role, description) values (4,  'DPC_REVIEWER',   'REVIEWER',      'DPC Reviewer');
insert into role (id, role, security_role, description) values (5,  'DPC_CHAIR',      'REVIEWER',      'DPC Chair');
insert into role (id, role, security_role, description) values (6,  'DC_REVIEWER',    'REVIEWER',      'DC Reviewer');
insert into role (id, role, security_role, description) values (7,  'DC_CHAIR',       'REVIEWER',      'DC Chair');
insert into role (id, role, security_role, description) values (8,  'DEAN_REVIEWER',  'REVIEWER',      'Dean Reviewer');
insert into role (id, role, security_role, description) values (9,  'DEAN_CHAIR',     'REVIEWER',      'Dean Chair');
insert into role (id, role, security_role, description) values (10, 'TPRC_REVIEWER',  'REVIEWER',      'TPRC Reviewer');
insert into role (id, role, security_role, description) values (11, 'TPRC_CHAIR',     'REVIEWER',      'TPRC Chair');
insert into role (id, role, security_role, description) values (12, 'EXCLUDED',       'EXCLUDED',      'Excluded');
insert into role (id, role, security_role, description) values (13, 'ADMINISTRATOR',  'ADMINISTRATOR', 'Administrator');
insert into role (id, role, security_role, description) values (14, 'SUPER_USER',     'SUPERUSER',     'Superuser');

-- Developers.
insert into person (id, uhuuid, name, email, username) values (2, '17958670', 'Frank Duckart','duckart@hawaii.edu','duckart');

-- Administrators.
insert into person (id, uhuuid, name, email, username) values ( 5, '10000002', 'Keith Richards',  'krichards@example.com', 'krichards');

insert into person (id, uhuuid, name, email, username) values (22, '12345678', 'Test Staff3', 'test3@hawaii.edu',   'test22');
insert into person (id, uhuuid, name, email, username) values (23, '89999999', 'Test Admin',  'admin@example.com',  'test23');
insert into person (id, uhuuid, name, email, username) values (24, '10000001', 'Test Tester', 'tester@example.com', 'test24');
insert into person (id, uhuuid, name, email, username) values (25, '10000004', 'Test Admin',  'admin4@example.com', 'test25');
insert into person (id, uhuuid, name, email, username) values (26, '10000003', 'Test Admin',  'admin3@example.com', 'test26');

insert into system_role (id, person_id, role_id, office_id) values ( 2,  2, 14, 11);
insert into system_role (id, person_id, role_id, office_id) values ( 5,  5, 13, 11);
insert into system_role (id, person_id, role_id, office_id) values (25, 23, 13, 11);
insert into system_role (id, person_id, role_id, office_id) values (26, 24, 13, 11);
insert into system_role (id, person_id, role_id, office_id) values (28, 25,  3, 11);
insert into system_role (id, person_id, role_id, office_id) values (29, 26,  3, 11);
insert into system_role (id, person_id, role_id, office_id) values (30, 26, 13, 11);
insert into system_role (id, person_id, role_id, office_id) values (31,  2, 13, 11);
