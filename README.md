# TodoApi api for fooji

I have a policy that if I'm doing take home challenges, I use them as an oportunity to learn something. With that in mind, I have implemented a graphql api.

The Api covers the following features
1. signup as a user
2. singin as the user (jwt based)
3. creating todos
4. viewing all todos
5. deleting todos
6. adding labels to a todo
7. removing a label from a todo

I also added a reasonable amount of unit test coverage to make sure everything runs smoothly.

There are 3 database tables Users have many todos and todos have many labels. Instead of having labels belong to many through a join table, I opted instead to have each label belong only to a single todo and use a compound unique constraint to ensure database integrity.




## TODOs
1. Label schema - done
2. Conceerns - set of allowed operations
    1. create user -done 
    2. get_token for user - done
    3. create a todo - done
    4. edit todo - done
    5. add label to todo -done
    6. remove label from todo
3. signup - done
4. signin - done
5. todo -> create, update, delete - done
6. add labels to todos - for grouping
    * add labels to the todo on creation - done
    * add label to a todo after the fact - done
    * remove a label from a todo - done
    * get all todos for a set of labels - done




