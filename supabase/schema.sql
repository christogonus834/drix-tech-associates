create table services(id bigint generated always as identity primary key,title text not null,description text,icon text default 'bulb',sort int default 0);
create table projects(id bigint generated always as identity primary key,title text not null,category text,tag text,image_url text,sort int default 0);
create table posts(id bigint generated always as identity primary key,title text not null,tag text,image_url text,body text,published_at date default current_date);
create table plans(id bigint generated always as identity primary key,name text not null,tagline text,price numeric,features text,featured boolean default false,sort int default 0);
create table testimonials(id bigint generated always as identity primary key,name text not null,role text,quote text,photo_url text);
create table slides(id bigint generated always as identity primary key,headline text not null,subtext text,image_url text,sort int default 0);
create table settings(id bigint generated always as identity primary key,brand text,about text,email text,address text);
-- Storage bucket for images uploaded from the admin panel (public so uploaded photos are viewable on the site)
insert into storage.buckets (id, name, public) values ('media','media', true) on conflict (id) do nothing;

create table team(id bigint generated always as identity primary key,name text not null,position text,bio text,photo_url text,linkedin text,twitter text,instagram text,sort int default 0);
create table consultations(id bigint generated always as identity primary key,name text,email text,project_type text,details text,status text default 'new',created_at timestamptz default now());
alter table services enable row level security;alter table projects enable row level security;alter table posts enable row level security;
alter table plans enable row level security;alter table testimonials enable row level security;alter table consultations enable row level security;
alter table slides enable row level security;alter table settings enable row level security;alter table team enable row level security;

insert into settings(brand,about,email,address) values
('DRIX TECH ASSOCIATES','A creative digital agency helping businesses grow with innovative solutions.','hello@drixtech.com','123 Business Street, New York, USA');

insert into services(title,description,icon,sort) values
('Web Design','Modern, responsive websites that convert visitors into customers.','palette',0),
('Web Development','High-performance websites built with the latest technologies.','code',1),
('Mobile App Development','Native and cross-platform mobile apps built for performance and scale.','smartphone',2),
('UI/UX Design','User-centered designs that create meaningful experiences.','layout',3),
('Digital Marketing','Data-driven marketing strategies to grow your brand online.','megaphone',4),
('SEO Optimization','Improve your search rankings and drive organic traffic.','search',5),
('Database Management and Optimization','Reliable, well-tuned databases that keep your systems fast and secure.','database',6),
('Brand Identity','Build a strong brand identity that stands out in the market.','bulb',7);

insert into plans(name,tagline,price,features,featured,sort) values
('Starter','Perfect for small projects',49000,'1 Website
Basic SEO
5 Pages
Email Support',false,0),
('Professional','Best for growing businesses',99000,'5 Websites
Advanced SEO
15 Pages
Priority Support',true,1),
('Enterprise','For large-scale businesses',199000,'Unlimited Websites
Premium SEO
Unlimited Pages
24/7 Support',false,2);

insert into slides(headline,subtext,image_url,sort) values
('Digital Solutions That Drive Real *Business* Growth','We craft high-performing websites, powerful applications, and digital strategies that help brands stand out and scale faster.','https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=1200&q=80&auto=format&fit=crop',0),
('Websites and Apps Built to *Scale*','From first sketch to launch, our team ships fast, reliable software your customers love.','https://images.unsplash.com/photo-1551434678-e076c223a692?w=1200&q=80&auto=format&fit=crop',1),
('Strategy, Design and *Growth* Under One Roof','One partner for branding, marketing and engineering, so your message stays consistent.','https://images.unsplash.com/photo-1531482615713-2afd69097998?w=1200&q=80&auto=format&fit=crop',2);

insert into team(name,position,bio,photo_url,linkedin,twitter,sort) values
('Daniel Okoye','Founder & CEO','Leads product strategy and client partnerships across every DRIX engagement.','https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=500&q=80&auto=format&fit=crop','https://linkedin.com','https://twitter.com',0),
('Amaka Chukwu','Lead Designer','Crafts interfaces that balance brand identity with everyday usability.','https://images.unsplash.com/photo-1580489944761-15a19d654956?w=500&q=80&auto=format&fit=crop','https://linkedin.com','',1),
('Emeka Obi','Lead Developer','Builds and scales the backend systems behind every DRIX product.','https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&q=80&auto=format&fit=crop','https://linkedin.com','',2),
('Ifeoma Nwosu','Marketing Manager','Runs growth and digital marketing strategy for client campaigns.','https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&q=80&auto=format&fit=crop','','https://twitter.com',3);
