# UdyamSetu - AI-Driven Scheme Matching (SIH26092)

Flutter mobile app prototype for Smart India Hackathon 2026, Problem Statement 
SIH26092 — "AI-Driven Scheme Matching for Marginalized Entrepreneurs" under the 
Ministry of Social Justice and Empowerment.

## Idea

Instead of making users search through government scheme portals, this app lets 
them describe their need in plain language (text or voice) and finds the right 
scheme for them — checking eligibility, explaining why it matches, calculating 
EMI, and routing them to an authorized Channel Partner.

## Current status: Phase 1 (UI + navigation, dummy data)

All 10 MVP screens are built and fully navigable, running on local dummy data 
(3 sample schemes, 3 sample channel partners). No backend, Gemini API key, or 
Google Maps key is needed yet — those come in later phases.

**Flow:** Splash → Login → Home Dashboard → AI Assistant (chat) → Eligibility 
confirm → Matched Schemes (ranked, explainable) → Scheme Details → EMI 
Calculator / Documents / Nearby Partners → My Applications.

