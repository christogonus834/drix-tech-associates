# DRIX backend

1. Create a Supabase project, run supabase/schema.sql in its SQL editor.
   This also creates a public "media" storage bucket used for admin image uploads.
2. Fill in .env with your real values (Supabase URL/key, admin email/password, JWT secret).
3. npm install && npm start

Endpoints:
- Public: /api/services, /api/projects, /api/posts, /api/plans, /api/testimonials,
  /api/slides, /api/settings, /api/team, POST /api/consultations
- Admin (needs Authorization: Bearer <token> from POST /api/login):
  GET/POST /api/admin/:table, PUT/DELETE /api/admin/:table/:id
  POST /api/admin/upload — multipart "file" field, returns { url } (image uploads)
