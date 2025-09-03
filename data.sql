-- Insert test roles
INSERT INTO roles (role_name) VALUES ('CUSTOMER') ON CONFLICT (role_name) DO NOTHING;
INSERT INTO roles (role_name) VALUES ('MAKER') ON CONFLICT (role_name) DO NOTHING;
INSERT INTO roles (role_name) VALUES ('CHECKER') ON CONFLICT (role_name) DO NOTHING;

-- Insert lookup data
INSERT INTO gender_lookup (gender_name) VALUES ('Male') ON CONFLICT (gender_name) DO NOTHING;
INSERT INTO gender_lookup (gender_name) VALUES ('Female') ON CONFLICT (gender_name) DO NOTHING;
INSERT INTO gender_lookup (gender_name) VALUES ('Other') ON CONFLICT (gender_name) DO NOTHING;

INSERT INTO marital_status_lookup (status_name) VALUES ('Single') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO marital_status_lookup (status_name) VALUES ('Married') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO marital_status_lookup (status_name) VALUES ('Divorced') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO marital_status_lookup (status_name) VALUES ('Widowed') ON CONFLICT (status_name) DO NOTHING;

INSERT INTO occupation_lookup (occupation_name) VALUES ('Software Engineer') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Doctor') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Teacher') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Business Owner') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Business Analyst') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Government Employee') ON CONFLICT (occupation_name) DO NOTHING;
INSERT INTO occupation_lookup (occupation_name) VALUES ('Others') ON CONFLICT (occupation_name) DO NOTHING;

INSERT INTO loan_status_lookup (status_name) VALUES ('DRAFT') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO loan_status_lookup (status_name) VALUES ('SUBMITTED') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO loan_status_lookup (status_name) VALUES ('UNDER_REVIEW') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO loan_status_lookup (status_name) VALUES ('PENDING_CHECKER_APPROVAL') ON CONFLICT (status_name) DO NOTHING;
INSERT INTO loan_status_lookup (status_name) VALUES ('APPROVED_BY_CHECKER') ON CONFLICT (status_name) DO NOTHING;

INSERT INTO document_types (name) VALUES ('Aadhar Card') ON CONFLICT (name) DO NOTHING;
INSERT INTO document_types (name) VALUES ('PAN Card') ON CONFLICT (name) DO NOTHING;
INSERT INTO document_types (name) VALUES ('Salary Slip') ON CONFLICT (name) DO NOTHING;
INSERT INTO document_types (name) VALUES ('Bank Statement') ON CONFLICT (name) DO NOTHING;
INSERT INTO document_types (name) VALUES ('Property Documents') ON CONFLICT (name) DO NOTHING;

-- Insert test users (password is 'password123' encoded with BCrypt)
INSERT INTO users (username, password_hash, is_new_user, activation_at, updated_at) 
VALUES ('vinay@email.com', '$2a$10$QsDSKZkDzyP6r1mNWd14F.31lrQQkbdibIwCBpM3LyKKPE7nAXnye', false, NOW(), NOW()) 
ON CONFLICT (username) DO NOTHING;

INSERT INTO users (username, password_hash, is_new_user, activation_at, updated_at) 
VALUES ('shruti@email.com', '$2a$10$QsDSKZkDzyP6r1mNWd14F.31lrQQkbdibIwCBpM3LyKKPE7nAXnye', false, NOW(), NOW()) 
ON CONFLICT (username) DO NOTHING;

INSERT INTO users (username, password_hash, is_new_user, activation_at, updated_at) 
VALUES ('divya@email.com', '$2a$10$QsDSKZkDzyP6r1mNWd14F.31lrQQkbdibIwCBpM3LyKKPE7nAXnye', false, NOW(), NOW()) 
ON CONFLICT (username) DO NOTHING;

-- Insert test bank members
INSERT INTO members (username, password_hash, role_id) 
SELECT 'kaushik', '$2a$10$QsDSKZkDzyP6r1mNWd14F.31lrQQkbdibIwCBpM3LyKKPE7nAXnye', r.id
FROM roles r WHERE r.role_name = 'MAKER'
ON CONFLICT (username) DO NOTHING;

INSERT INTO members (username, password_hash, role_id) 
SELECT 'nipun', '$2a$10$QsDSKZkDzyP6r1mNWd14F.31lrQQkbdibIwCBpM3LyKKPE7nAXnye', r.id
FROM roles r WHERE r.role_name = 'CHECKER'
ON CONFLICT (username) DO NOTHING;

-- Insert personal details for users
INSERT INTO personal_details (user_id, first_name, last_name, email, date_of_birth, gender_id, marital_status_id, phone_number, current_address, permanent_address, aadhaar_number, pan_number, updated_at)
SELECT u.customer_id, 'Vinay', 'Kumar', 'vinay@email.com', '1995-03-15', g.id, m.id, '+91-9876543210', '123 Tech Park, Electronic City, Bangalore, Karnataka, 560100', '123 Tech Park, Electronic City, Bangalore, Karnataka, 560100', '123456789012', 'ABCDE1234F', NOW()
FROM users u, gender_lookup g, marital_status_lookup m 
WHERE u.username = 'vinay@email.com' AND g.gender_name = 'Male' AND m.status_name = 'Single'
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO personal_details (user_id, first_name, last_name, email, date_of_birth, gender_id, marital_status_id, phone_number, current_address, permanent_address, aadhaar_number, pan_number, updated_at)
SELECT u.customer_id, 'Shruti', 'Sharma', 'shruti@email.com', '1993-07-22', g.id, m.id, '+91-9123456789', '456 Green Avenue, Koramangala, Bangalore, Karnataka, 560034', '456 Green Avenue, Koramangala, Bangalore, Karnataka, 560034', '987654321098', 'FGHIJ5678K', NOW()
FROM users u, gender_lookup g, marital_status_lookup m 
WHERE u.username = 'shruti@email.com' AND g.gender_name = 'Female' AND m.status_name = 'Married'
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO personal_details (user_id, first_name, last_name, email, date_of_birth, gender_id, marital_status_id, phone_number, current_address, permanent_address, aadhaar_number, pan_number, updated_at)
SELECT u.customer_id, 'Divya', 'Patel', 'divya@email.com', '1996-09-10', g.id, m.id, '+91-8765432109', '789 Brigade Road, MG Road, Bangalore, Karnataka, 560025', '789 Brigade Road, MG Road, Bangalore, Karnataka, 560025', '456789123456', 'LMNOP9876Q', NOW()
FROM users u, gender_lookup g, marital_status_lookup m 
WHERE u.username = 'divya@email.com' AND g.gender_name = 'Female' AND m.status_name = 'Single'
ON CONFLICT (user_id) DO NOTHING;

-- Insert employment details for users
INSERT INTO employment_details (user_id, employer_name, job_title, work_experience_years, annual_income, employer_address, occupation_id, updated_at)
SELECT u.customer_id, 'TechCorp Solutions Pvt Ltd', 'Senior Software Engineer', 4, 1020000.00, 'Manyata Tech Park, Nagavara, Bangalore', o.id, NOW()
FROM users u, occupation_lookup o 
WHERE u.username = 'vinay@email.com' AND o.occupation_name = 'Software Engineer'
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO employment_details (user_id, employer_name, job_title, work_experience_years, annual_income, employer_address, occupation_id, updated_at)
SELECT u.customer_id, 'Manipal Hospital', 'Consultant Physician', 6, 1440000.00, 'HAL Airport Road, Marathahalli, Bangalore', o.id, NOW()
FROM users u, occupation_lookup o 
WHERE u.username = 'shruti@email.com' AND o.occupation_name = 'Doctor'
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO employment_details (user_id, employer_name, job_title, work_experience_years, annual_income, employer_address, occupation_id, updated_at)
SELECT u.customer_id, 'Accenture Services Pvt Ltd', 'Business Analyst', 3, 780000.00, 'Embassy Golf Links, Intermediate Ring Road, Bangalore', o.id, NOW()
FROM users u, occupation_lookup o 
WHERE u.username = 'divya@email.com' AND o.occupation_name = 'Business Analyst'
ON CONFLICT (user_id) DO NOTHING;

-- Insert loan applications
INSERT INTO loan_applications (user_id, status_id, created_at, updated_at)
SELECT u.customer_id, s.id, '2025-08-15 10:30:00', NOW()
FROM users u, loan_status_lookup s
WHERE u.username = 'vinay@email.com' AND s.status_name = 'PENDING_CHECKER_APPROVAL'
ON CONFLICT (application_id) DO NOTHING;

INSERT INTO loan_applications (user_id, status_id, created_at, updated_at)
SELECT u.customer_id, s.id, '2025-08-20 14:15:00', NOW()
FROM users u, loan_status_lookup s
WHERE u.username = 'shruti@email.com' AND s.status_name = 'UNDER_REVIEW'
ON CONFLICT (application_id) DO NOTHING;

INSERT INTO loan_applications (user_id, status_id, created_at, updated_at)
SELECT u.customer_id, s.id, '2025-08-25 16:45:00', NOW()
FROM users u, loan_status_lookup s
WHERE u.username = 'divya@email.com' AND s.status_name = 'SUBMITTED'
ON CONFLICT (application_id) DO NOTHING;

-- Insert loan details
INSERT INTO loan_details (application_id, loan_type, amount, tenure_months, interest_rate, maker_comments, maker_id, maker_approved_at, updated_at)
SELECT la.application_id, 'Personal Loan', 500000.00, 36, 12.5, 'All documents verified. Good credit profile.', m.member_id, '2025-08-16 11:45:00', NOW()
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' AND m.username = 'kaushik'
ON CONFLICT (application_id) DO NOTHING;

INSERT INTO loan_details (application_id, loan_type, amount, tenure_months, interest_rate, maker_comments, checker_comments, maker_id, checker_id, maker_approved_at, updated_at)
SELECT la.application_id, 'Home Loan', 2500000.00, 240, 8.75, 'Excellent income profile. Property documents pending verification.', 'Under review for final approval.', m1.member_id, m2.member_id, '2025-08-21 16:30:00', NOW()
FROM loan_applications la, members m1, members m2, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' AND m1.username = 'kaushik' AND m2.username = 'nipun'
ON CONFLICT (application_id) DO NOTHING;

INSERT INTO loan_details (application_id, loan_type, amount, tenure_months, interest_rate, updated_at)
SELECT la.application_id, 'Car Loan', 800000.00, 60, 9.5, NOW()
FROM loan_applications la, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com'
ON CONFLICT (application_id) DO NOTHING;

-- Insert nominee details
INSERT INTO nominee_details (application_id, nominee_name, relationship, nominee_address, nominee_phone, nominee_pan, nominee_dob, updated_at)
SELECT la.application_id, 'Priya Kumar', 'Sister', '789 MG Road, Indiranagar, Bangalore', '+91-9876543210', 'KLMNO9012P', '1992-11-08', NOW()
FROM loan_applications la, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com'
ON CONFLICT (nominee_id) DO NOTHING;

INSERT INTO nominee_details (application_id, nominee_name, relationship, nominee_address, nominee_phone, nominee_pan, nominee_dob, updated_at)
SELECT la.application_id, 'Amit Sharma', 'Husband', '456 Green Avenue, Koramangala, Bangalore', '+91-9123456789', 'PQRST3456U', '1990-12-10', NOW()
FROM loan_applications la, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com'
ON CONFLICT (nominee_id) DO NOTHING;

INSERT INTO nominee_details (application_id, nominee_name, relationship, nominee_address, nominee_phone, nominee_pan, nominee_dob, updated_at)
SELECT la.application_id, 'Rakesh Patel', 'Father', '789 Brigade Road, MG Road, Bangalore', '+91-9876543210', 'UVWXY7890Z', '1968-05-15', NOW()
FROM loan_applications la, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com'
ON CONFLICT (nominee_id) DO NOTHING;

-- Insert application status history
INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, m.member_id, 'DRAFT', 'SUBMITTED', 'Application submitted by customer', '2025-08-15 10:30:00'
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' AND m.username = 'kaushik'
ON CONFLICT (application_id, changed_at) DO NOTHING;

INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, m.member_id, 'SUBMITTED', 'UNDER_REVIEW', 'Moved to maker review', '2025-08-16 09:15:00'
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' AND m.username = 'kaushik'
ON CONFLICT (application_id, changed_at) DO NOTHING;

INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, m.member_id, 'UNDER_REVIEW', 'PENDING_CHECKER_APPROVAL', 'Approved by maker, ready for checker review', '2025-08-16 11:45:00'
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' AND m.username = 'kaushik'
ON CONFLICT (application_id, changed_at) DO NOTHING;

INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, m.member_id, 'DRAFT', 'SUBMITTED', 'Application submitted by customer', '2025-08-20 14:15:00'
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' AND m.username = 'kaushik'
ON CONFLICT (application_id, changed_at) DO NOTHING;

INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, m.member_id, 'SUBMITTED', 'UNDER_REVIEW', 'Moved to checker review', '2025-08-21 10:45:00'
FROM loan_applications la, members m, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' AND m.username = 'nipun'
ON CONFLICT (application_id, changed_at) DO NOTHING;

INSERT INTO application_status_history (application_id, member_id, previous_status, new_status, comments, changed_at)
SELECT la.application_id, NULL, 'DRAFT', 'SUBMITTED', 'Application submitted by customer', '2025-08-25 16:45:00'
FROM loan_applications la, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com'
ON CONFLICT (application_id, changed_at) DO NOTHING;

-- Insert loan document records for the users
INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/vinay_aadhar_card.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' 
AND dt.name = 'Aadhar Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/vinay_pan_card.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' 
AND dt.name = 'PAN Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/vinay_salary_slip.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' 
AND dt.name = 'Salary Slip'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/vinay_bank_statement.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'vinay@email.com' 
AND dt.name = 'Bank Statement'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

-- Documents for Shruti
INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/shruti_aadhar_card.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' 
AND dt.name = 'Aadhar Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/shruti_pan_card.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' 
AND dt.name = 'PAN Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/shruti_salary_slip.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' 
AND dt.name = 'Salary Slip'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/shruti_bank_statement.pdf', true
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' 
AND dt.name = 'Bank Statement'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/shruti_property_documents.pdf', false
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'shruti@email.com' 
AND dt.name = 'Property Documents'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

-- Documents for Divya
INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/divya_aadhar_card.pdf', false
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com' 
AND dt.name = 'Aadhar Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/divya_pan_card.pdf', false
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com' 
AND dt.name = 'PAN Card'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/divya_salary_slip.pdf', false
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com' 
AND dt.name = 'Salary Slip'
ON CONFLICT (application_id, document_type_id) DO NOTHING;

INSERT INTO loan_documents (application_id, document_type_id, file_path, is_verified)
SELECT la.application_id, dt.document_type_id, '/uploads/documents/divya_bank_statement.pdf', false
FROM loan_applications la, document_types dt, users u
WHERE la.user_id = u.customer_id AND u.username = 'divya@email.com' 
AND dt.name = 'Bank Statement'
ON CONFLICT (application_id, document_type_id) DO NOTHING;
