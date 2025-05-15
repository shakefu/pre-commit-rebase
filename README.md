# pre-commit-rebase

Always rebase your branches.

## Usage

```yaml
- repo: https://github.com/shakefu/pre-commit-rebase
  rev: v0.1.0
  hooks:
    - id: rebase
      # Optionally specify the default branch, instead of discovering it
      # args: [main]
```
