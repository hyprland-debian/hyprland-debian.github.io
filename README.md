## This is the branch with an action

The action can be dispathed by adding this to your workflow:

```yaml
- uses: debian-hyprland/debian-hyprland.github.io@trigger-refresh
  with:
    token: ${{ secrets.GH_REFRESH_TOKEN }}
```
