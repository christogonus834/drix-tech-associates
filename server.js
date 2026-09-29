require('dotenv').config();
const express=require('express'),cors=require('cors'),jwt=require('jsonwebtoken'),path=require('path');
const {createClient}=require('@supabase/supabase-js');
const db=createClient(process.env.SUPABASE_URL,process.env.SUPABASE_SERVICE_KEY);
const app=express();app.use(cors(),express.json());
const PUBLIC=['services','projects','posts','plans','testimonials','slides','settings','team'];
const ALL=[...PUBLIC,'consultations'];
const auth=(req,res,next)=>{try{jwt.verify((req.headers.authorization||'').replace('Bearer ',''),process.env.JWT_SECRET);next()}catch{res.status(401).json({error:'Unauthorized'})}};
const send=(res,{data,error})=>error?res.status(400).json({error:error.message}):res.json(data);
app.post('/api/login',(req,res)=>{const{email,password}=req.body;
 if(email===process.env.ADMIN_EMAIL&&password===process.env.ADMIN_PASSWORD)
  return res.json({token:jwt.sign({admin:true},process.env.JWT_SECRET,{expiresIn:'8h'})});
 res.status(401).json({error:'Wrong email or password'})});
app.post('/api/consultations',async(req,res)=>{const{name,email,project_type,details}=req.body;
 if(!name||!/\S+@\S+/.test(email||''))return res.status(400).json({error:'Name and valid email required'});
 send(res,await db.from('consultations').insert({name,email,project_type,details}).select().single())});
PUBLIC.forEach(t=>app.get(`/api/${t}`,async(req,res)=>send(res,await db.from(t).select('*').order(t=='settings'?'id':'sort',{ascending:true}).limit(t=='settings'?1:1000))));
app.use('/api/admin/:t',auth,(req,res,next)=>ALL.includes(req.params.t)?next():res.status(404).json({error:'Unknown resource'}));
app.get('/api/admin/:t',async(req,res)=>send(res,await db.from(req.params.t).select('*').order('id',{ascending:false})));
app.post('/api/admin/:t',async(req,res)=>send(res,await db.from(req.params.t).insert(req.body).select().single()));
app.put('/api/admin/:t/:id',async(req,res)=>{delete req.body.id;send(res,await db.from(req.params.t).update(req.body).eq('id',req.params.id).select().single())});
app.delete('/api/admin/:t/:id',async(req,res)=>send(res,await db.from(req.params.t).delete().eq('id',req.params.id)));
const fs=require('fs');
const pub=path.join(__dirname,'public');
if(fs.existsSync(pub))app.use(express.static(pub)); // only used if you keep frontend+backend together
app.get('/',(req,res)=>fs.existsSync(pub)?res.sendFile(path.join(pub,'index.html')):res.json({ok:true,message:'DRIX backend is running'}));
app.listen(process.env.PORT||3000,()=>console.log('Running on http://localhost:'+(process.env.PORT||3000)));
