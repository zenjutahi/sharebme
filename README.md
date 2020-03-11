# Sharebme file Transfer
A simple web based file transfer application.

## Install

### Clone the repository

```shell
https://github.com/zenjutahi/sharebme.git
cd sharebme
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.6.0`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

### Initialize the database

```shell
rails db:create db:migrate
```

### Serve

```shell
rails s
```
### Expected Views
#### Welcome View
![Alt text](https://zenjy.s3-us-west-2.amazonaws.com/Screenshot+2020-03-10+at+12.31.29.png "Optional title")

#### Sign Up View
![Alt text](https://zenjy.s3-us-west-2.amazonaws.com/Screenshot+2020-03-10+at+12.36.47.png "Optional title")

#### Login View
![Alt text](https://zenjy.s3-us-west-2.amazonaws.com/Screenshot+2020-03-10+at+12.36.36.png "Optional title")

#### DashBoard View after creating a folder
![Alt text](https://zenjy.s3-us-west-2.amazonaws.com/Screenshot+2020-03-10+at+12.30.56.png "Optional title")


## Licensing
This app is licensed under the MIT license.
