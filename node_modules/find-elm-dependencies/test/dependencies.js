var expect = require("chai").expect;
var path = require("path");
var findAllDependencies = require(path.join(__dirname, "..")).findAllDependencies;

var fixturesDir = path.join(__dirname, "fixtures");

function prependFixturesDir(filename) {
  return path.join(fixturesDir, filename);
}

describe("#findAllDependencies", function() {

  it("works for a main file without an explicit module statement", function () {
    return findAllDependencies(prependFixturesDir("SimplestMain.elm")).then(function(results) {
      expect(results).to.deep.equal([])
    });
  });

  it("works for a port module with three dependencies", function () {
    return findAllDependencies(prependFixturesDir("ParentWithPort.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm", "Test/ChildB.elm", "Native/Child.js" ].map(prependFixturesDir)
      );
    });
  });

  it("works for a module with comments between lines with three dependencies", function () {
    return findAllDependencies(prependFixturesDir("ParentWithUnindentedMultilineComment.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm", "Test/ChildB.elm", "Native/Child.js" ].map(prependFixturesDir)
      );
    });
  });

  it("works for a non-port module with three dependencies", function () {
    return findAllDependencies(prependFixturesDir("Parent.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm", "Test/ChildB.elm", "Native/Child.js" ].map(prependFixturesDir)
      );
    });
  });

  it("works for a file with nested dependencies", function () {
    return findAllDependencies(prependFixturesDir("ParentWithNestedDeps.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm", "Test/Sample/NestedChild.elm", "Test/ChildB.elm", "Native/Child.js" ].map(prependFixturesDir)
      );
    });
  });

  it("works for a non-root file with nested dependencies", function () {
    return findAllDependencies(prependFixturesDir(
        path.join("Nested", "Parent", "Test.elm"))).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm", "Nested/Child.elm", "Nested/Test/Child.elm", "Test/Sample/NestedChild.elm", "Test/ChildB.elm", "Native/Child.js" ].map(prependFixturesDir)
      );
    });
  });

  it("works for a file with dependencies stored in another source directory", function () {
    return findAllDependencies(prependFixturesDir("ParentWithOtherSrcDeps.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "other-src/OtherChild.elm" ].map(prependFixturesDir)
      );
    });
  });

  it("ignores an elm-package.json file that does not list the module's source directory", function() {
    return findAllDependencies(prependFixturesDir("other-src/OtherParent.elm")).then(function(results) {
      expect(results).to.deep.equal(
        [ "Test/ChildA.elm" ].map(prependFixturesDir)
      );
    });
  });

  it("ignores an elm-package.json file missing the source-directories key", function() {
    return findAllDependencies(prependFixturesDir("no-source-directories-elm-package-json/Main.elm")).then(function(results) {
      expect(results).to.deep.equal([]);
    });
  });

  it("gracefully ignores malformed elm-package.json files", function() {
    return findAllDependencies(prependFixturesDir("malformed-elm-package-json/Main.elm")).then(function(results) {
      expect(results).to.deep.equal([]);
    })
  });
});
