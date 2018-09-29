#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>

new const PLUGIN[] = "||Reset Score||"
new const VERSION[] = "0.1"
new const AUTHOR[] = "ScrewedUP"

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_clcmd("say /rs","cmd_rs");
	register_clcmd("say_team /rs","cmd_rs");
	register_clcmd("say rs","cmd_rs");
	register_clcmd("say_team rs","cmd_rs");
}

public cmd_rs(id)
{
	new szname[33];
	get_user_name(id,szname,charsmax(szname));
	set_user_frags(id,0);
	cs_set_user_deaths(id,0);
	printmr(id,"^4|^3| ^4Reset Score ^3|^4| ^3%s ^4YOUR SCORE ^1HAVE BEEN SET TO ^4[0]",szname);
	return PLUGIN_HANDLED;
}

stock printmr(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4")
	replace_all(msg, 190, "!y", "^1")
	replace_all(msg, 190, "!t", "^3")
	replace_all(msg, 190, "!t2", "^0")
	
	if (id) players[0] = id; else get_players(players, count, "ch")

	for (new i = 0; i < count; i++)
	{
		if (is_user_connected(players[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
			write_byte(players[i])
			write_string(msg)
			message_end()
		}
	}
}


