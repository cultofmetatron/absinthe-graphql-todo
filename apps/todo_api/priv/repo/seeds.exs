# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodoApi.Repo.insert!(%TodoApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TodoApi.Repo
alias TodoApi.Schema.User
alias TodoApi.Schema.User.Todo
alias TodoApi.Schema.User.Label

#create base user
user = User.signup_changeset(%User{}, %{
  email: "foobar@example.com",
  password: "foobar677",
  password_confirmation: "foobar677"
}) |> Repo.insert!

# add some Todos

todo1 = user |> Todo.create_changeset(%{
  content: "do the laundry"
}) |> Repo.insert!()
todo2 = user |> Todo.create_changeset(%{
  content: "do the dishes"
}) |> Repo.insert!()
todo3 = user |> Todo.create_changeset(%{
  content: "skydive"
}) |> Repo.insert!()

# add some labels

user |> Label.create_changeset(todo1, %{
  text: "chores"
}) |> Repo.insert!()


user |> Label.create_changeset(todo2, %{
  text: "chores"
}) |> Repo.insert!()


user |> Label.create_changeset(todo3, %{
  text: "yolo"
}) |> Repo.insert!()



