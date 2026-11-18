# AI Usage Report — ResumeCraft

## AI tool used
ChatGPT (AI development assistant).

## Representative prompts
1. "Identify at least eight functional requirements and two non-functional requirements for an online resume builder."
2. "Identify the primary actor, supporting systems and exceptional cases for this resume builder."
3. "Create a use case diagram and activity diagram for entering resume data, validating it, previewing it and downloading PDF."
4. "Design a responsive HTML/CSS/JavaScript resume builder with personal, education, experience and skills sections."
5. "Add client-side validation for required name and valid email fields."
6. "Implement a live resume preview and dynamic add/remove education and experience rows."
7. "Connect a JavaScript application to Supabase for inserting, retrieving and updating resume data."
8. "Generate a PDF from the resume preview using a JavaScript PDF library."

## Tasks assisted by AI
- Requirement analysis and edge-case identification.
- Initial diagram planning and Mermaid diagram drafting.
- HTML form and responsive CSS layout.
- JavaScript live preview, validation and repeatable form sections.
- Supabase integration starter and SQL schema.
- PDF generation and deployment instructions.

## Example of AI-generated code modified/corrected
The application uses HTML escaping before inserting user-entered text into preview markup. This prevents user input such as `<script>` from being interpreted as HTML. The `escapeHTML()` helper in `script.js` replaces special HTML characters.

## Limitations / errors to watch for
1. AI-generated Supabase code may fail if the URL, anon key, table schema or Row Level Security policies are not configured correctly.
2. CDN-based PDF generation requires an internet connection; if the library fails to load, PDF generation cannot start.
3. A static frontend cannot safely contain a Supabase service-role key. Only the anon/public key may be used in browser code, with proper authentication and RLS policies.

## Verification performed / to perform
- Check required name and email validation.
- Test invalid email and empty form submission.
- Add and remove multiple education and experience entries.
- Confirm preview updates as fields change.
- Save and reload in local demo mode.
- When Supabase is configured, test insert, select and update operations.
- Download the PDF and inspect its layout.
- Test the page at desktop and mobile widths.

## Technical defense
- Functional requirement: what the system does.
- Non-functional requirement: quality or constraint such as usability and performance.
- CRUD: Create, Read, Update and Delete.
- Primary key: unique identifier for a row.
- Foreign key: column that references another table's primary key.
- Validation: checks input before processing.
- Deployment: publishing the application so it can be accessed online.
- PDF library: html2pdf.js converts the resume preview into a downloadable PDF.
