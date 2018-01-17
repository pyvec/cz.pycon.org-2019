PyConCZ 2018
============

PyCon CZ taking place in Prague for its fourth edition.

Contributing
------------

PyCon CZ website is using Python 3.5/Django for the backend, NodeJS for
bundling frontend assets and Postgresql as a database.

### Setup dev environment

#### Django



Inside `pyconcz_2018` directory,
run following commands to setup project for local development:

1.	You can either use sqlite database, if you only need to work with
	static pages and styles, in which case, you don't need to setup
	anything. Or, if you need to work with dynamic apps, you need to
	use postgresql.

	Prepare postgresql database: user `pyconcz`, password empty, database `pyconcz`

    E.g. on Mac:

    ```
    $ createuser --pwprompt pyconcz
    $ createdb -Opyconcz -Eutf8 pyconcz
    ```

1.  `python3 -m venv env` _note: Use exactly Python 3.5.2 on Windows (otherwise Pillow won't install with pip) so you might want to `py -3.5 -m venv env`_
1.  `pip install -r requirements-dev.txt`
1.	copy `pyconcz_2018/settings/local_template_dev.py` to `pyconcz_2018/settings/local.py`
1.  `./manage.py migrate`


#### Static files

**You only need this if you work with styles or images**. 

For styles and images processing to work, you need to have `node.js` and _gulp-cli_ installed globally (`sudo npm install gulp-cli -g`)

Inside root directory (the same directory where `manage.py` is) run `npm install`


### Development

#### Django

You can run your dev server manually on [http://localhost:8000]() with:

`./manage.py runserver --settings=pyconcz_2018.settings.local`


#### Static files

To start development with static files being processed run `gulp`. It will also start dev server for you.

Open [http://localhost:3000]() and you should see development version of website with automatic compiling and reloading.

Everything in `/static/css` and `/static/img` is replaced with 
processed content of `/static_src/css` and `/static_src/img` respectively.
So don't edit anything inside `/static/css` and `/static/img` manually.

Same would go for own JavaScript but we don’t have any.


### Building

After each production build, you have to commit newly generated CSS and image files.
Old files are automatically replaced.

1. `npm run build`
1. `git add pyconcz_2018/static`


### Deployment

Just use `fab production deploy` to deploy to production or `fab beta deploy` to deploy to beta site.

License
-------

This work is licensed under a [MIT](./LICENSE.md)
