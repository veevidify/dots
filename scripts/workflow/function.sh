#region - local os
function dev() {
	source ~/scripts/workflow/start-tmux.sh
}
function today() {
	echo ""
}
function attach_dev() {
	tmux attach-session -t dev
}
function vo() {
	fd . "$HOME" -H \
		--exclude ".git" \
		--exclude "node_modules" \
		--exclude ".cache" \
	| fzf \
		--preview 'bat {}' \
		--bind 'enter:become(vim {})'
}
function vc() {
	fd -H \
		--exclude ".git" \
		--exclude "node_modules" \
		--exclude ".cache" \
	| fzf \
		--preview 'bat {}' \
		--bind 'enter:become(vim {})'
}
function search() {
	fd . / -H \
		--exclude ".git" \
		--exclude "node_modules" \
		--exclude ".cache" \
	| fzf \
		--preview 'bat {}' \
		--bind 'enter:become(vim {})'
}
function dotfiles() {
	/usr/bin/git --git-dir=$HOME/devs/dots --work-tree=$HOME "$@"
}
function backupdot() {
	dotfiles add -u; dotfiles commit -m "upd"; dotfiles push -u origin main;
}
#endregion
