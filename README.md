# Phoenix-Sekeleton

## Feature Roadmap
- [x] Basic routing
- [x] Authentication
    - [x] hard-wired
    - [x] from Database (Ecto/Postgres)
    - [ ] Salted, hashed passwords
- [ ] Authorization
    - [ ] Userroles Ecto defintion
    - [ ] Hello2.Authorization.check_user_roles([roles]) )
- [x] Memcahed Session store
- [x] Django Templates (erlyDTL)
- [x] Ecto models
- [ ] call/process external programs via procelain (mainly for PDF generation)
- [ ] pluggable Navigation tree
- [ ] CouchDB connector
- [ ] Hello2.Admin.RESTCrud controller
    - [ ] validate/save
    - [ ] uploads
    - [ ] Image resizing
- [ ] TinySite CMS
- [ ] Create mix task to boostrap components inszead of copy/paste+search/replace

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


## Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `Hello2.Router.start`
