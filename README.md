# ASP.NET Identity Example
Simple ASP.NET Core Identity WebAssembly with MySQL

#### Bugfix ASP.NET Scaffolded items by running it manually
1. Install Code generator tool.
```shell
dotnet tool install -g dotnet-aspnet-codegenerator
```
2. Install **Microsoft.VisualStudio.Web.CodeGeneration.Design** if not exists.
```shell
Install-Package Microsoft.VisualStudio.Web.CodeGeneration.Design
```
3. Generate ``DbContext`` if needed.
```shell
dotnet aspnet-codegenerator identity -dc MyProject.Data.MyDbContext
```
4. Generate scaffolded items
```shell
dotnet aspnet-codegenerator identity -dc MyProject.Data.MyDbContext
```
5. Generate specific scaffolded items
```shell
dotnet aspnet-codegenerator identity -dc MyProject.Data.MyDbContext –files "Account.Login;Account.Manage.EnableAuthenticator;Account.Manage.Disable2fa;Account.Manage.ResetAuthenticator;Account.Manage.SetPassword"
```
