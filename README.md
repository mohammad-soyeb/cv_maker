# ResumeCraft — CV Management System

A responsive HTML, CSS and JavaScript application with account login, a premium responsive navigation bar, and three main workspace pages: Dashboard, Create New CV, and Edit CV.

## Main features
- Sign up, sign in and log out.
- Premium top navigation with Dashboard, Create CV, Edit CV, user identity and logout.
- Dashboard lists all CVs saved by the signed-in user.
- Create multiple CVs; each CV is saved separately.
- Edit an existing CV and save changes to the same record.
- Delete saved CVs.
- Live resume preview and PDF download.
- Add/remove multiple education and experience entries.
- Supabase Authentication + PostgreSQL database + user-scoped Row Level Security.
- Local demo mode for quick testing without Supabase (browser-only; not secure or cross-device).

## Design update
- Modern indigo/violet visual system, refined typography, soft shadows and responsive layouts.
- Sticky navigation bar with active page state and compact mobile navigation.
- Redesigned dashboard cards, editor panels, authentication screen and resume preview.

## Run in VS Code
1. Extract the ZIP file.
2. Open the `Online_Resume_Builder` folder in VS Code.
3. Install the **Live Server** extension if needed.
4. Right-click `index.html` → **Open with Live Server**.
5. The login screen appears. In demo mode, choose **Create an account**, register an email/password, then sign in.
6. Create a CV. Use **Save CV** to store it on the Dashboard.
7. From Dashboard, use **Edit CV**, **PDF**, or delete.

No `npm install` or `npm run dev` is needed. Internet is required for the CDN libraries, Google Fonts and PDF generation.

## Supabase setup (required for real online accounts)
1. Create a Supabase project.
2. Open **SQL Editor** and run the complete `database/schema.sql` file.
3. In Supabase Project Settings → API, copy the Project URL and anon/public key.
4. Paste them into `config.js` as `supabaseUrl` and `supabaseAnonKey`.
5. In Supabase Authentication settings, configure the allowed site/redirect URLs for local testing and your deployed Netlify/Vercel URL. Email confirmation may need to be completed after registration, depending on your Supabase settings.
6. Reload the site, register a new account, and sign in.

The SQL enables RLS and limits select/insert/update/delete to `auth.uid() = user_id`. Each account can access only its own CVs. Never place a Supabase `service_role` key in frontend code. Use the anon/public key only.

## Demo mode warning
If `config.js` is left empty, login and CVs use browser localStorage so you can demonstrate the page flow without a backend. This is only a classroom UI demo: passwords are not securely handled, and accounts/CVs are not shared across browsers or devices. Do not use real passwords or sensitive personal data in demo mode. Configure Supabase before public deployment.

## Deploy to Netlify or Vercel
Deploy the extracted project folder as a static site with `index.html` at the root. Configure Supabase first if you need real user accounts and cloud CV storage. Add your deployed domain to Supabase Auth's allowed redirect/site URLs. The frontend is static; Supabase provides authentication and database services separately.

## Project files
- `index.html` — login/register view, dashboard, CV editor and preview.
- `style.css` — responsive design.
- `script.js` — authentication, dashboard, CV CRUD, preview and PDF logic.
- `config.js` — Supabase project configuration.
- `database/schema.sql` — resumes table, trigger and user-specific RLS policies.
- `docs/requirements-and-diagrams.md` — requirements and design diagrams.
- `docs/ai-usage-report.md` — AI usage report and technical defense notes.


## CV naming and design templates
- Give every CV a custom name before saving it. This name is used in the dashboard and the Edit CV library.
- Open **Edit CV** in the navigation to see a simple list of saved CV names. Select a name to open its editor.
- In the live preview, choose one of three PDF layouts: Classic, Modern, or Elegant. The selected layout changes the preview and the downloaded PDF; it does not change the saved CV content.
- Download the selected design from the preview panel.


## New productivity features
- Dashboard analytics for saved CV count and latest activity.
- Browser-local automatic draft saving with a restore prompt after signing in again.
- Basic rule-based CV completeness score (not an official ATS score or hiring prediction).
- Duplicate a saved CV from the dashboard.
- Dark mode preference saved in the current browser.
- Typed inputs: email, telephone, date of birth, URL, month/year for experience, and numeric graduation year.
- LinkedIn and portfolio links appear in the resume contact line.
- Optional profile photo (JPG/PNG/WebP, maximum 1 MB).
- Separate Projects and Certifications sections in the form and CV preview.

### Database update
If you already created the Supabase table, run the latest `database/schema.sql` again. It includes `ALTER TABLE ... ADD COLUMN IF NOT EXISTS` statements for date of birth, LinkedIn, portfolio, profile photo, projects, and certifications fields.

Auto-saved drafts and dark-mode preference are browser-local. The ATS readiness indicator is a simple completeness checklist, not an external ATS integration.
