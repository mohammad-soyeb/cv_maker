# ResumeCraft — Requirement Analysis & Software Design

## 1. Functional Requirements
- FR-01: The system shall allow a user to enter personal information (name, email, phone, location and headline).
- FR-02: The system shall allow a user to add one or more educational qualifications.
- FR-03: The system shall allow a user to add one or more professional experiences.
- FR-04: The system shall allow a user to enter skills and additional information.
- FR-05: The system shall generate and display a structured resume preview.
- FR-06: The system shall allow the user to modify entered resume information.
- FR-07: The system shall generate and download the resume as a PDF file.
- FR-08: The system shall save, retrieve and update resume data.
- FR-09: The system shall validate required fields and email format before saving or PDF generation.

## 2. Non-Functional Requirements
- NFR-01 Usability: The interface shall be easy to understand and responsive on desktop and mobile.
- NFR-02 Performance: Preview updates should happen immediately after user input; PDF generation should complete within a reasonable time for a normal resume.

## 3. Actors
- Primary actor: User — enters, edits, previews, saves, loads and downloads resume information.
- Supporting external service: Supabase database — stores and returns resume records. It is a system component, not a human actor.

## 4. Edge Cases
1. Required name or email is empty.
2. Email address has an invalid format.
3. User attempts to download a PDF without valid required details.
4. User enters very long descriptions or many education/experience entries.
5. Supabase is unavailable or configuration/policies are incorrect.

## 5. Use Case Diagram
```mermaid
flowchart LR
  U[User]
  subgraph System[Online Resume Builder]
    UC1((Enter personal information))
    UC2((Add education))
    UC3((Add experience))
    UC4((Add skills))
    UC5((Preview resume))
    UC6((Edit resume))
    UC7((Save / Load resume))
    UC8((Download PDF))
    UC9((Validate input))
  end
  U --- UC1
  U --- UC2
  U --- UC3
  U --- UC4
  U --- UC5
  U --- UC6
  U --- UC7
  U --- UC8
  UC7 -. includes .-> UC9
  UC8 -. includes .-> UC9
```

## 6. Activity Diagram
```mermaid
flowchart TD
  A([Start]) --> B[Enter personal, education, experience and skills]
  B --> C[Validate required fields and email]
  C --> D{Input valid?}
  D -- No --> E[Show validation message]
  E --> B
  D -- Yes --> F[Generate live resume preview]
  F --> G{Need modification?}
  G -- Yes --> B
  G -- No --> H[Save resume data]
  H --> I{Database available?}
  I -- No --> J[Save in browser local storage]
  I -- Yes --> K[(Supabase resumes table)]
  J --> L[Generate PDF]
  K --> L
  L --> M{PDF generated?}
  M -- No --> N[Show error and retry]
  N --> L
  M -- Yes --> O[Download PDF]
  O --> P([End])
```

## 7. Class Diagram
```mermaid
classDiagram
  class User {
    +int userId
    +string name
    +string email
    +createResume()
  }
  class Resume {
    +uuid resumeId
    +string title
    +string summary
    +save()
    +update()
    +preview()
  }
  class Education {
    +int educationId
    +string degree
    +string institution
    +string year
  }
  class Experience {
    +int experienceId
    +string position
    +string company
    +string duration
  }
  class Skill {
    +int skillId
    +string skillName
  }
  class PDFGenerator {
    +string fileName
    +generatePDF()
  }
  User "1" --> "0..*" Resume : owns
  Resume "1" --> "0..*" Education : contains
  Resume "1" --> "0..*" Experience : contains
  Resume "1" --> "0..*" Skill : contains
  Resume ..> PDFGenerator : uses
```

## 8. DFD Level 0 (Context Diagram)
```mermaid
flowchart LR
  U[User] -->|Resume information and commands| S((Online Resume Builder))
  S -->|Preview, validation messages and PDF| U
  S <-->|Save and retrieve resume data| DB[(Resume Database)]
```

## 9. DFD Level 1
```mermaid
flowchart LR
  U[User]
  P1((1.0 Collect Information))
  P2((2.0 Validate Information))
  P3((3.0 Generate Preview))
  P4((4.0 Save / Retrieve / Update))
  P5((5.0 Generate PDF))
  D1[(D1 Resume Database)]
  U -->|Form data| P1
  P1 -->|Entered data| P2
  P2 -->|Invalid input message| U
  P2 -->|Valid data| P3
  P3 -->|Resume preview| U
  P3 -->|Resume data| P4
  P4 <-->|Resume records| D1
  P4 -->|Selected resume| P3
  P3 -->|Approved resume| P5
  P5 -->|PDF file| U
```

## 10. ERD
The deployed demo uses one `resumes` table with JSONB arrays for education, experience and skills to keep setup fast. A normalized logical ERD is shown below and can be implemented as separate tables if required by the instructor.

```mermaid
erDiagram
  USER ||--o{ RESUME : owns
  RESUME ||--o{ EDUCATION : has
  RESUME ||--o{ EXPERIENCE : has
  RESUME ||--o{ SKILL : has
  USER {
    int user_id PK
    string name
    string email
  }
  RESUME {
    uuid resume_id PK
    int user_id FK
    string title
    text summary
  }
  EDUCATION {
    int education_id PK
    uuid resume_id FK
    string degree
    string institution
    string year
  }
  EXPERIENCE {
    int experience_id PK
    uuid resume_id FK
    string position
    string company
    string duration
  }
  SKILL {
    int skill_id PK
    uuid resume_id FK
    string skill_name
  }
```

## 11. Database operations
See `../database/schema.sql` for table creation, sample insert, select and update statements.

## 12. Implementation mapping
- Frontend: HTML form and resume preview.
- Styling: responsive CSS.
- Client-side logic: JavaScript validation, dynamic repeated fields and preview.
- PDF: html2pdf.js.
- Data persistence: browser localStorage in local demo mode; optional Supabase PostgreSQL integration when URL/key are configured.
- Hosting: Netlify static hosting.
