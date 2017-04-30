# TodoApi api

Todo list:
* signup page
* signin page


I have a policy that if I'm doing take home challenges, I use them as an oportunity to learn something. With that in mind, I have implemented a graphql api using phoenix 1.3 beta and absinthe, a graphql library for elixir.

The Api covers the following features
1. signup as a user
2. signin as the user (jwt based)
3. creating todos
4. viewing all todos
5. deleting todos
6. adding labels to a todo
7. removing a label from a todo

I also added a reasonable amount of unit test coverage to make sure everything runs smoothly.

There are 3 database tables Users have many todos and todos have many labels. Instead of having labels belong to many through a join table, I opted instead to have each label belong only to a single todo and use a compound unique constraint to ensure database integrity.

I rather like the gmail system of labels so instead of strict groupings, you can apply tags to a todo. a todo can have multiple tags and multiple todos can have a tag. We can query based on the inclusion of said tags.

The top level is an umbrella app with two subapps.

**todo_api** contains the database validation logic for the application. 

**todo_api_web** contains the graphql specific parts. I also stubbed out a webpack frontend build system.

### Setup

You're going to need to install the latest elixir as well as postgresql

```
brew install elixir
```

once you clone the repo, you need to install the dependencies

```
mix deps.get
```

From there you'll need to modify `apps/todo_api/config/dev.exs` for your database settings

```elixir
# Configure your database
config :todo_api, TodoApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "todo_api_dev",
  hostname: "localhost",
  pool_size: 10

```

Unfortunately, phoenix1.3 is still in beta, you'll need to cd into the
database sub application to run the database tasks.

```
cd apps/todo_api/
mix ecto.reset
```
This will create a user in the database which you can login with

```
email: "foobar@example.com",
password: "foobar677",
```

to run the server

```
mix phx.server
```


### runnign the tests
once you've edited the `apps/todo_api/config/test.exs` file, you can fun the tests.

start phantomjs in a seperate window for the integration tests

```
phantomjs --wd
```


```
mix test
```

### sample queries

> Note: You'll need an app like [graphiql](https://github.com/graphql/graphiql) to test the queries.

#### Signup
```graphql
mutation Signup {
  signup(email: "foobar16@gmail.com", password: "ferngully", password_confirmation: "ferngully") {
    id
    email
    jwt
  }
}
```

#### Signin
```
mutation Signin {
  signin(email: "foobar14@gmail.com", password: "ferngully") {
    id
    email
    jwt
  }
}
```
> Note: the rest of the endpoints require a jwt header. I had to impliment a custom jwt handler to give a graphql appropriate response. you can see it in `apps/todo_api_web/lib/jwt_manager.ex`. Once you get the jwt, you'll need to set your http header `Authorization: "Bearer #{jwt}"`.

#### Create a todo
```graphql
mutation CreateTodo {
  createTodo(content: "go sleading", description: "nothing", labels: ["yoloswag", "going awesome"]) {
    id
    content
    description
    done
    labels {
      id
      text
    }
  }
}
```
#### Update a Todo
```graphql
mutation UpdateTodo {
  updateTodo(id:"9661b898-205b-4ca8-9ef7-d6c98d71146f", done: true) {
    id
    content
    description
    done
  }
}

```

#### Delete a todo
```graphql
mutation DeleteTodo {
  deleteTodo(id:"c4a82f70-5956-493a-a122-d627b545b2f7") {
		id
  }
}

```
>note id is the TODO id, not the label
#### Add a label to a todo
```graphql
mutation AddLabel {
	addLabel(id: "ff04ca18-2af8-4c66-93a9-5fcf79695fba", label: "buffoon") {
    id

  }
}

```

#### removing a label
```graphql
mutation RemoveLabel {
	removeLabel(id: "ff04ca18-2af8-4c66-93a9-5fcf79695fba", label: "buffoon") {
    id

  }
}
```

#### finding all the todos
```graphql
{
  todos {
    id
    content
    description
    done
    labels {
      id
      text
    }
  }
}
```

with labels (for grouping)

```graphql
{
  todos(labels: ["yoloswag"]) {
    id
    content
    description
    done
    labels {
      id
      text
    }
  }
}
```



