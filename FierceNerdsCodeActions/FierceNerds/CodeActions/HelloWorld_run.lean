import Lean.Server.CodeActions
import Std.CodeAction
import FierceNerdsUtil.FierceNerds.Util.Thoughts_macro

namespace FierceNerds.CodeActions

open Lean Server Lsp
open FierceNerds Util

namespace HelloWorld

@[code_action_provider] def dummyCodeActionProvider : CodeActionProvider := fun params snap => do
  let dummy_action : LazyCodeAction := {
    eager := {
      title := "Dummy",
      edit? := .some {
        documentChanges := #[]
      }
    }
  }
  return #[dummy_action]

@[code_action_provider] def helloWorldCodeActionProvider : CodeActionProvider := fun params snap => do
  let { textDocument, range, .. } := params
  let { uri } := textDocument
  let textDocument : VersionedTextDocumentIdentifier := { uri }
  -- let range : Range := ⟨⟨0, 0⟩, ⟨0, 0⟩⟩
  let hello_world_action : LazyCodeAction := {
    eager := {
      title := "Hello world",
      edit? := .some {
        changes := .ofList [
            ⟨uri, #[
              {
                range
                newText := "Hello world"
              }
            ]⟩
         ]
        }
      }
    }
  return #[hello_world_action]

def test : Nat → Nat := sorry

def todo : List Thought := [
  ⟨
    "Ensure that helloWorldCodeActionProvider returns an action that inserts 'Hello world'",
    [
      "Try adding annotations",
      "Try adding `changes` instead of `documentChanges`",
      "Try tracing the changes"
    ]
  ⟩
]
