\# Sunrise Dental Clinic Management System



A web-based Dental Clinic Management System developed for the \*\*CIS6003 Advanced Programming\*\* module.



The system is designed to computerize patient, appointment, dentist, treatment, billing, authentication, and reporting activities at Sunrise Dental Clinic. It aims to reduce manual record handling, prevent appointment conflicts, improve information management, and provide a more efficient workflow for clinic staff.



\---



\## 📌 Project Overview



Sunrise Dental Clinic is a private dental clinic that manages a large number of patients and appointments. Manual management of patient records and appointments can lead to problems such as:



\- Double bookings

\- Lost or inconsistent patient records

\- Long waiting times

\- Billing errors

\- Difficulties locating patient information

\- Inefficient appointment management



This system provides a centralized web-based solution for managing these activities through a user-friendly interface.



\---



\## ✨ Main Features



\### 🔐 User Authentication



\- Secure staff login

\- Username and password authentication

\- Session-based access control

\- First-login handling for new users

\- Logout functionality



\### 👥 Patient Management



\- Register new patients

\- View patient information

\- Edit patient information

\- Search patients by patient ID/name

\- Display patient codes

\- Store contact information

\- Store email and address information



\### 📅 Appointment Management



\- Create new appointments

\- Search/select patients when creating appointments

\- Search/select dentists

\- Select treatment types

\- Select appointment date and time

\- Display appointment details

\- Manage appointment records

\- Help prevent appointment conflicts



\### 👨‍⚕️ Dentist Management



\- Manage dentist records

\- Search/select dentists during appointment creation

\- Display dentist information



\### 🦷 Treatment Management



\- Manage available treatments

\- Associate treatments with appointments

\- Use treatment information for billing calculations



\### 💳 Billing



\- Calculate treatment costs

\- Include consultation fees

\- Generate patient bills/receipts

\- Display billing information



\### 📊 Reports



The system provides reports to support clinic management and decision-making.



Examples include:



\- Appointment statistics

\- Patient-related statistics

\- Treatment-related information

\- Billing-related information



\### 🍪 Cookie Management



The system uses browser cookies for selected functionality.



Implemented cookies include:



| Cookie | Purpose | Duration |

|---|---|---|

| `cookieConsent` | Stores the user's cookie-consent preference | 30 days |

| `guideCompleted` | Stores whether the user has completed the initial system guide | Until cookie expiry |



The `first\_login` value is stored as a database field rather than a browser cookie.



\---



\## 🏗️ System Architecture



The application follows a layered / three-tier approach consisting of:



```text

Presentation Layer

&#x20;       ↓

Controller Layer

&#x20;       ↓

Business / Service Layer

&#x20;       ↓

DAO / Data Access Layer

&#x20;       ↓

Database

