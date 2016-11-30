#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables.sh"
echo "# ${Var_script_name} started at: $(date -u +%s)"
Var_install_v2_name="${Var_install_v2_name}"
Func_run_sanely "cp -va ${Var_install_v2_name} ${Var_install_path}/${Var_install_v2_name}" "0"
Func_run_sanely "chmod 754 ${Var_install_path}/${Var_install_v2_name}" "0"
Var_check_path="$(echo "${PATH}" | grep -q "${Var_install_path}")"
if [ -z "${Var_check_path}" ]; then
	echo "${Var_script_name}: PATH+=\":${Var_install_path}\""
	export PATH+=":${Var_install_path}"
fi
Func_run_sanely "${Var_install_path}/${Var_install_v2_name} --version" "${USER}"
if [ -e "${Var_install_v2_name}" ]; then
## Encryption listener
	${Var_install_v2_name}\
 --debug-level="0"\
 --log-level="7"\
 --enc-yn="yes"\
 --enc-parsing-disown="yes"\
 --enc-copy-save-yn="no"\
 --enc-copy-save-path="${Var_script_copy_four_name_encrypt}"\
 --enc-copy-save-ownership="${USER}:${USER}"\
 --enc-copy-save-permissions="750"\
 --script-log-path="${Var_encrypt_pipe_four_log}"\
 --enc-pipe-permissions="660"\
 --enc-parsing-output-permissions="660"\
 --enc-parsing-recipient="${Var_gnupg_email}"\
 --enc-parsing-output-rotate-recipient="${Var_gnupg_email}"\
 --enc-pipe-file="${Var_encrypt_pipe_four_location}"\
 --enc-parsing-output-file="${Var_encrypted_four_location}"\
 --enc-parsing-bulk-out-dir="${Var_encrypted_four_bulk_dir}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
## Decryption listener
	${Var_install_v2_name}\
 --debug-level="0"\
 --log-level="8"\
 --dec-yn="yes"\
 --dec-parsing-disown-yn="yes"\
 --dec-bulk-check-sleep="5"\
 --dec-bulk-check-count-max='5'\
 --script-log-path="${Var_decrypt_four_log}"\
 --dec-pass="${Var_pass_location}"\
 --dec-parsing-save-output-yn="yes"\
 --dec-parsing-output-file="${Var_decrypt_raw_four_location}"\
 --enc-parsing-output-file="${Var_encrypted_four_location}"\
 --dec-parsing-bulk-out-dir="${Var_bulk_decryption_four_dir}"\
 --enc-parsing-bulk-out-dir="${Var_encrypted_four_bulk_dir}"\
 --dec-pipe-make-yn='yes'\
 --dec-pipe-file="${Var_encrypted_four_location}"\
 --dec-pipe-permissions="660"\
 --dec-pipe-ownership="${USER}:${USER}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
else
	echo "# ${Var_script_name} could not find: ${Var_install_path}/${Var_install_v2_name}"
	exit 1
fi
if [ -p "${Var_encrypt_pipe_four_location}" ]; then
	echo "# ${Var_script_name} running: touch \"${Var_raw_test_four_location}\""
	touch "${Var_raw_test_four_location}"
	echo "# ${Var_script_name} running: chmod 660 \"${Var_raw_test_four_location}\""
	chmod 660 "${Var_raw_test_four_location}"
	_test_string="$(base64 /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c"${Var_pass_length}")"
	echo "${_test_string}" >> "${Var_raw_test_four_location}"
	_current_string="$(tail -n1 "${Var_raw_test_four_location}")"
	echo "# ${Var_script_name} running as ${USER}: echo \"${_current_string}\" > \"${Var_encrypt_pipe_four_location}\""
	echo "${_current_string}" > "${Var_encrypt_pipe_four_location}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
	_test_string="$(base64 /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c"${Var_pass_length}")"
	echo "${_test_string}" >> "${Var_raw_test_four_location}"
	_current_string="$(tail -n1 "${Var_raw_test_four_location}")"
	echo "# ${Var_script_name} running as ${USER}: echo \"${_current_string}\" > \"${Var_encrypt_pipe_four_location}\""
	echo "${_current_string}" > "${Var_encrypt_pipe_four_location}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
	_test_string="$(base64 /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c"${Var_pass_length}")"
	echo "${_test_string}" >> "${Var_raw_test_four_location}"
	_current_string="$(tail -n1 "${Var_raw_test_four_location}")"
	echo "# ${Var_script_name} running as ${USER}: echo \"${_current_string}\" > \"${Var_encrypt_pipe_four_location}\""
	echo "${_current_string}" > "${Var_encrypt_pipe_four_location}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
	echo "# ${Var_script_name} running as ${USER}: echo \"quit\" > \"${Var_encrypt_pipe_four_location}\""
	echo "quit" > "${Var_encrypt_pipe_four_location}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}"
	if [ -r "${Var_encrypt_pipe_four_log}" ]; then
		echo "# ${Var_script_name} running: cat \"${Var_encrypt_pipe_four_log}\""
		cat "${Var_encrypt_pipe_four_log}"
	fi
else
	echo "# Error - ${Var_script_name} could not find: ${Var_encrypt_pipe_four_location}"
	exit 1
fi
if ! [ -p "${Var_encrypt_pipe_four_location}" ]; then
	echo "# ${Var_script_name} detected pipe corectly removed: ${Var_encrypt_pipe_four_location}"
else
	echo "# ${Var_script_name} detected pipe still exsists: ${Var_encrypt_pipe_four_location}"
	ls -hal "${Var_encrypt_pipe_four_location}"
	echo "# ${Var_script_name} will cleanup: ${Var_encrypt_pipe_four_location}"
	rm -v "${Var_encrypt_pipe_four_location}"
fi
if [ -p "${Var_encrypted_four_location}" ]; then
	echo "# ${Var_script_name} detected remaining pipe: ${Var_encrypted_four_location}"
	rm -vf "${Var_encrypted_four_location}"
else
	echo "# ${Var_script_name} did not detect remaining pipe: ${Var_encrypted_four_location}"
fi
_background_processes="$(ps aux | grep "${Var_install_v2_name}" | grep -v grep)"
if [ "${#_background_processes}" -gt '0' ]; then
	echo -e "# ${Var_script_name} reports background processes still running:\n#\n$(ps aux | grep "${Var_install_v2_name}" | grep -v grep)\n#"
	_background_pid="$(ps aux | grep "${Var_install_v2_name}" | grep -v grep | awk '{print $2}')"
	for _pid in ${_background_pid}; do
		echo "# ${Var_script_name} killing: ${_pid}"
		kill ${_pid}
	done
else
	echo "# ${Var_script_name} did not detect any background processes"
fi
if [ -r "${Var_decrypt_raw_four_location}" ] && [ -r "${Var_raw_test_four_location}" ]; then
	_decrypted_strings="$(cat "${Var_decrypt_raw_four_location}")"
	_raw_strings="$(cat "${Var_raw_test_four_location}")"
	_diff_results="$(diff <(cat "${Var_decrypt_raw_four_location}") <(cat "${Var_raw_test_four_location}"))"
	echo -e "# Contence of decrypted strings #\n${_decrypted_strings}"
	echo -e "# Contence of un-encrypted strings #\n${_raw_strings}"
	if [ "${#_diff_results}" != "0" ]; then
		echo -e "# Diff results #\n${_diff_results}"
	else
		echo "# ${Var_script_name} reports: no differance between strings!"
	fi
	if [ -r "${Var_decrypt_four_log}" ]; then
		echo "# ${Var_script_name} running: cat \"${Var_decrypt_four_log}\""
		cat "${Var_decrypt_four_log}"
	fi
elif ! [ -r "${Var_decrypt_raw_four_location}" ]; then
	echo "# ${Var_script_name} could not read file: ${Var_decrypt_raw_four_location}"
	exit 1
elif ! [ -r "${Var_raw_test_four_location}" ]; then
	echo "# ${Var_script_name} could not read file: ${Var_raw_test_four_location}"
	exit 1
else
	echo "# ${Var_script_name} could not proceed"
	exit 2
fi
echo "# ${Var_script_name} reports encryption to decryption: Passed"
echo "# ${Var_script_name} finished at: $(date -u +%s)"
