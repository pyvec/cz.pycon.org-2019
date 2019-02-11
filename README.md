PyConCZ 2019
============

PyCon CZ taking place in Ostrava for its fifth edition.

Contributing
------------

### Workflow

While we can accept pull requests from outside repositiories it’s probably easier if you just ask us to be a contributor.

- `master` branch is manually deployed to https://cz.pycon.org/
    - commit directly to `master` only if it’s a _hotfix_ 
- create _feature_ branches (named whatever you want) for your work
    - create PR’s to merge into `master`
    - you can merge `master` freely into a feature branch to keep it current
- `beta` branch is manually deployed to beta (URL and credentials available at Pyvec Slack).
    - freely merge into `beta` anything you need to preview including work in progress
    - never merge from `beta` to anywhere


### Setup dev environment

PyCon CZ website is using Python 3.5/Django for the backend, NodeJS for
bundling frontend assets and Postgresql as a database.


#### Django

Run following commands to setup project for local development:

1.  You can use sqlite database if you only need to work with static pages and styles. 
    
    In a case you need to work with dynamic apps setup postgresql create role and db via CLI:

    ```
    # su -c psql postgres
    postgres=# CREATE ROLE pycon2019 LOGIN ENCRYPTED PASSWORD 'your fancy password';
    postgres=# CREATE DATABASE "pycon2019" WITH ENCODING='UTF8' OWNER=pycon2019;
    ```

    You can also use PostgreSQL localy in Docker container:
    `$ docker run --name pyconcz2019-pg -e POSTGRES_PASSWORD="your fancy password" -e POSTGRES_USER=pycon2019 -d -p 5432:5432 postgres`

1.  `python3 -m venv env` _note: Use exactly Python 3.5.2 on Windows (otherwise Pillow won't install with pip) so you might want to `py -3.5 -m venv env`_
1.  `pip install -r requirements-dev.txt`
1.  copy `pyconcz/settings/local_template_dev.py` to `pyconcz/settings/local.py`
    and don't forget to set DATABASES and SECRET_KEY settings.
1.  `./manage.py migrate`


#### Static files

**You only need this if you work with styles or images**. 

For styles and images processing to work, you need to have `node.js` installed.

In root directory (the same directory where `manage.py` is) run `npm install`


### Development

#### Django

You can run your dev server manually on [http://localhost:8000]() with:

`./manage.py runserver --settings=pyconcz.settings.local`


#### HTML

We have some non-semantic HTML to accomodate the design.
Hopefully this is temporary, until a CSS wizard tames the madness.
Things to watch out for:

* Headers `<h1>` and `<h2>` need an extra `<span>` inside for the content:

  ```html
      <h1><span>PyCon CZ Team</span></h1>
  ```

* Sections (with the headers above) need to be wrapped in double `<div>`.
  Alternate between `pc-odd-section` and `pc-even-section` classes:

  ```html
      <div class="pc-odd-section">
          <div class="container">
              ...
          </div>
      </div>
  ```

* If you end with `pc-even-section`, adjust the footer by adding the
  following block:

    ```html
        {% block footer-class %}pc-odd-footer{% endblock %}
    ```

#### Static files

To start development with static files being processed run `npm start`. It will also start Django dev server for you.

Open [http://localhost:3838]() and you should see development version of website with automatic compiling and reloading.

You can also set your hosts to map 127.0.0.1 to `pycon.test` and it will work on [http://pycon.test:3838]().

Everything in `/static/css` and `/static/img` is replaced with 
processed content of `/static_src/css` and `/static_src/img` respectively so don't edit anything inside `/static/css` and `/static/img` manually.

Same would go for own JavaScript but we don’t have any.


### Building

After each production build, you have to commit newly generated CSS and image files.
Old files are automatically replaced.

1. `npm run build`
1. `git add pyconcz/static`


### Deployment

Just use `fab production deploy` to deploy to production or `fab beta deploy` to deploy to beta site.

License
-------

This work is licensed under a [MIT](./LICENSE.md)
