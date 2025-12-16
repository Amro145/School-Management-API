#!/bin/bash

# School Management API - Data Population Script
# This script populates the production API with sample data

API_URL="https://myapp.amroaltayeb14.workers.dev"
OUTPUT_FILE="data.json"

echo "{" > $OUTPUT_FILE
echo '  "timestamp": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'",' >> $OUTPUT_FILE
echo '  "api_url": "'$API_URL'",' >> $OUTPUT_FILE
echo '  "data": {' >> $OUTPUT_FILE

# Login as admin to get token
echo "Logging in as admin..."
LOGIN_RESPONSE=$(curl -s -X POST $API_URL/users/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@school.com", "password":"admin123"}')

ADMIN_TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Admin token obtained"

# Create Schools
echo "Creating schools..."
echo '    "schools": [' >> $OUTPUT_FILE

SCHOOL1=$(curl -s -X POST $API_URL/schools \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Springfield High School", "adminId":6}')
echo "      $SCHOOL1," >> $OUTPUT_FILE

SCHOOL2=$(curl -s -X POST $API_URL/schools \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Riverside Academy", "adminId":6}')
echo "      $SCHOOL2" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Create Subjects
echo "Creating subjects..."
echo '    "subjects": [' >> $OUTPUT_FILE

SUBJ1=$(curl -s -X POST $API_URL/subjects \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Mathematics"}')
echo "      $SUBJ1," >> $OUTPUT_FILE

SUBJ2=$(curl -s -X POST $API_URL/subjects \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Science"}')
echo "      $SUBJ2," >> $OUTPUT_FILE

SUBJ3=$(curl -s -X POST $API_URL/subjects \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"English"}')
echo "      $SUBJ3," >> $OUTPUT_FILE

SUBJ4=$(curl -s -X POST $API_URL/subjects \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"History"}')
echo "      $SUBJ4" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Create Classes
echo "Creating classes..."
echo '    "classes": [' >> $OUTPUT_FILE

CLASS1=$(curl -s -X POST $API_URL/classes \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Grade 10A", "schoolId":1}')
echo "      $CLASS1," >> $OUTPUT_FILE

CLASS2=$(curl -s -X POST $API_URL/classes \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Grade 10B", "schoolId":1}')
echo "      $CLASS2," >> $OUTPUT_FILE

CLASS3=$(curl -s -X POST $API_URL/classes \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"name":"Grade 11A", "schoolId":2}')
echo "      $CLASS3" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Create Connections (Teacher-Subject-Class)
echo "Creating connections..."
echo '    "connections": [' >> $OUTPUT_FILE

CONN1=$(curl -s -X POST $API_URL/connections/connect \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"classRoomId":1, "subjectId":1, "teacherId":7}')
echo "      $CONN1," >> $OUTPUT_FILE

CONN2=$(curl -s -X POST $API_URL/connections/connect \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"classRoomId":1, "subjectId":2, "teacherId":8}')
echo "      $CONN2," >> $OUTPUT_FILE

CONN3=$(curl -s -X POST $API_URL/connections/connect \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"classRoomId":2, "subjectId":1, "teacherId":7}')
echo "      $CONN3," >> $OUTPUT_FILE

CONN4=$(curl -s -X POST $API_URL/connections/connect \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"classRoomId":3, "subjectId":3, "teacherId":8}')
echo "      $CONN4" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Create Enrollments
echo "Creating enrollments..."
echo '    "enrollments": [' >> $OUTPUT_FILE

ENROLL1=$(curl -s -X POST $API_URL/enrollments/enroll \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":9, "classRoomId":1}')
echo "      $ENROLL1," >> $OUTPUT_FILE

ENROLL2=$(curl -s -X POST $API_URL/enrollments/enroll \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":10, "classRoomId":1}')
echo "      $ENROLL2," >> $OUTPUT_FILE

ENROLL3=$(curl -s -X POST $API_URL/enrollments/enroll \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":9, "classRoomId":2}')
echo "      $ENROLL3" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Create Grades
echo "Creating grades..."
echo '    "grades": [' >> $OUTPUT_FILE

GRADE1=$(curl -s -X POST $API_URL/grades \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":9, "classRoomId":1, "subjectId":1, "score":95, "type":"final"}')
echo "      $GRADE1," >> $OUTPUT_FILE

GRADE2=$(curl -s -X POST $API_URL/grades \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":9, "classRoomId":1, "subjectId":1, "score":88, "type":"midterm"}')
echo "      $GRADE2," >> $OUTPUT_FILE

GRADE3=$(curl -s -X POST $API_URL/grades \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":9, "classRoomId":1, "subjectId":2, "score":92, "type":"final"}')
echo "      $GRADE3," >> $OUTPUT_FILE

GRADE4=$(curl -s -X POST $API_URL/grades \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":10, "classRoomId":1, "subjectId":1, "score":87, "type":"final"}')
echo "      $GRADE4," >> $OUTPUT_FILE

GRADE5=$(curl -s -X POST $API_URL/grades \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"studentId":10, "classRoomId":1, "subjectId":2, "score":90, "type":"final"}')
echo "      $GRADE5" >> $OUTPUT_FILE
echo '    ],' >> $OUTPUT_FILE

# Get all data
echo "Fetching all data..."
echo '    "all_users": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/users >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_schools": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/schools >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_classes": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/classes -H "Authorization: Bearer $ADMIN_TOKEN" >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_subjects": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/subjects -H "Authorization: Bearer $ADMIN_TOKEN" >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_connections": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/connections/all -H "Authorization: Bearer $ADMIN_TOKEN" >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_enrollments": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/enrollments/all -H "Authorization: Bearer $ADMIN_TOKEN" >> $OUTPUT_FILE
echo ',' >> $OUTPUT_FILE

echo '    "all_grades": ' >> $OUTPUT_FILE
curl -s -X GET $API_URL/grades >> $OUTPUT_FILE

echo '' >> $OUTPUT_FILE
echo '  }' >> $OUTPUT_FILE
echo '}' >> $OUTPUT_FILE

echo "Data population complete! Output saved to $OUTPUT_FILE"
