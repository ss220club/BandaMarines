// SS220 START EDIT ADDICTION
// Style class macros

// Fontsizes
#define FONT_SIZE_HUGE(X, args...) "<span class='huge'>[ru_span(X, ##args, type="FONT_SIZE_HUGE")]</span>"
#define FONT_SIZE_XL(X, args...) "<span class='extra_large'>[ru_span(X, ##args, type="FONT_SIZE_XL")]</span>"
#define FONT_SIZE_LARGE(X, args...) "<span class='large'>[ru_span(X, ##args, type="FONT_SIZE_LARGE")]</span>"
#define FONT_SIZE_BIG(X, args...) "<span class='medium'>[ru_span(X, ##args, type="FONT_SIZE_BIG")]</span>"
#define FONT_SIZE_MEDIUM(X, args...) "<span class='small'>[ru_span(X, ##args, type="FONT_SIZE_MEDIUM")]</span>"

// Xeno related
#define SPAN_XENO(X, args...) "<span class='xeno'>[ru_span(X, ##args, type="SPAN_XENO")]</span>"
#define SPAN_XENOLEADER(X, args...) "<span class='xenoleader'>[ru_span(X, ##args, type="SPAN_XENOLEADER")]</span>"
#define SPAN_XENOQUEEN(X, args...) "<span class='xenoqueen'>[ru_span(X, ##args, type="SPAN_XENOQUEEN")]</span>"
#define SPAN_XENOANNOUNCE(X, args...) "<span class='xenoannounce'>[ru_span(X, ##args, type="SPAN_XENOANNOUNCE")]</span>"
#define SPAN_XENONOTICE(X, args...) "<span class='xenonotice'>[ru_span(X, ##args, type="SPAN_XENONOTICE")]</span>"
#define SPAN_XENOBOLDNOTICE(X, args...) "<span class='xenoboldnotice'>[ru_span(X, ##args, type="SPAN_XENOBOLDNOTICE")]</span>"
#define SPAN_XENODANGER(X, args...) "<span class='xenodanger'>[ru_span(X, ##args, type="SPAN_XENODANGER")]</span>"
#define SPAN_XENOHIGHDANGER(X, args...) "<span class='xenohighdanger'>[ru_span(X, ##args, type="SPAN_XENOHIGHDANGER")]</span>"
#define SPAN_XENOWARNING(X, args...) "<span class='xenowarning'>[ru_span(X, ##args, type="SPAN_XENOWARNING")]</span>"
#define SPAN_XENOMINORWARNING(X, args...) "<span class='xenominorwarning'>[ru_span(X, ##args, type="SPAN_XENOMINORWARNING")]</span>"

#define SPAN_PSYTALK(X, args...) "<span class='psy_talk'>[ru_span(X, ##args, type="SPAN_PSYTALK")]</span>"

// Yautja related
#define SPAN_YAUTJABOLD(X, args...) "<span class='yautjabold'>[ru_span(X, ##args, type="SPAN_YAUTJABOLD")]</span>"
#define SPAN_YAUTJABOLDBIG(X, args...) "<span class='yautjaboldbig'>[ru_span(X, ##args, type="SPAN_YAUTJABOLDBIG")]</span>"

// Announcements
#define SPAN_ANNOUNCEMENT_HEADER(X, args...) "<span class='announce_header'>[ru_span(X, ##args, type="SPAN_ANNOUNCEMENT_HEADER")]</span>"
#define SPAN_ANNOUNCEMENT_HEADER_BLUE(X, args...) "<span class='announce_header_blue'>[ru_span(X, ##args, type="SPAN_ANNOUNCEMENT_HEADER_BLUE")]</span>"
#define SPAN_ANNOUNCEMENT_HEADER_ADMIN(X, args...) "<span class='announce_header_admin'>[ru_span(X, ##args, type="SPAN_ANNOUNCEMENT_HEADER_ADMIN")]</span>"
#define SPAN_ANNOUNCEMENT_BODY(X, args...) "<span class='announce_body linkify'>[ru_span(X, ##args, type="SPAN_ANNOUNCEMENT_BODY")]</span>"

// Round and roles
#define SPAN_ROUNDHEADER(X, args...) "<span class='round_header'>[ru_span(X, ##args, type="SPAN_ROUNDHEADER")]</span>"
#define SPAN_ROUNDBODY(X, args...) "<span class='round_body'>[ru_span(X, ##args, type="SPAN_ROUNDBODY")]</span>"
#define SPAN_ROLE_HEADER(X, args...) "<span class='role_header'>[ru_span(X, ##args, type="SPAN_ROLE_HEADER")]</span>"
#define SPAN_ROLE_BODY(X, args...) "<span class='role_body'>[ru_span(X, ##args, type="SPAN_ROLE_BODY")]</span>"


// OOC
#define SPAN_XOOC(X, args...) "<span class='xooc'>[ru_span(X, ##args, type="SPAN_XOOC")]</span>"
#define SPAN_MOOC(X, args...) "<span class='mooc'>[ru_span(X, ##args, type="SPAN_MOOC")]</span>"
#define SPAN_YOOC(X, args...) "<span class='yooc'>[ru_span(X, ##args, type="SPAN_YOOC")]</span>"
#define SPAN_DEBUG(X, args...) "<span class='debuginfo'>[ru_span(X, ##args, type="SPAN_DEBUG")]</span>"
#define SPAN_COMBAT(X, args...) "<span class='attacklog'>[ru_span(X, ##args, type="SPAN_COMBAT")]</span>"
#define SPAN_ADMINNOTICE(X, args...) "<span class='adminnotice'>[ru_span(X, ##args, type="SPAN_ADMINNOTICE")]</span>"
#define SPAN_ADMIN(X, args...) "<span class='admin'>[ru_span(X, ##args, type="SPAN_ADMIN")]</span>"
#define SPAN_ADMINHELP(X, args...) "<span class='adminhelp'>[ru_span(X, ##args, type="SPAN_ADMINHELP")]</span>"
#define SPAN_ADMINSAY(X, args...) "<span class='adminsay'>[ru_span(X, ##args, type="SPAN_ADMINSAY")]</span>"
#define SPAN_MOD(X, args...) "<span class='mod'>[ru_span(X, ##args, type="SPAN_MOD")]</span>"
#define SPAN_MENTORHELP(X, args...) "<span class='mentorhelp'>[ru_span(X, ##args, type="SPAN_MENTORHELP")]</span>"
#define SPAN_MENTORSAY(X, args...) "<span class='mentorsay'>[ru_span(X, ##args, type="SPAN_MENTORSAY")]</span>"
#define SPAN_MENTORBODY(X, args...) "<span class='mentorbody'>[ru_span(X, ##args, type="SPAN_MENTORBODY")]</span>"
#define SPAN_NICHE(X, args...) "<span class='niche'>[ru_span(X, ##args, type="SPAN_NICHE")]</span>"

#define SPAN_PM(X, args...) "<span class='pm'>[ru_span(X, ##args, type="SPAN_PM")]</span>"

// Misc
#define SPAN_BOLD(X, args...) "<span class='bold'>[ru_span(X, ##args, type="SPAN_BOLD")]</span>"
#define SPAN_UNDERLINE(X, args...) "<span class='underline'>[ru_span(X, ##args, type="SPAN_UNDERLINE")]</span>"
#define SPAN_LARGE(X, args...) "<span class='large'>[ru_span(X, ##args, type="SPAN_LARGE")]</span>"

#define SPAN_BOLDANNOUNCE(X, args...) "<span class='boldannounce'>[ru_span(X, ##args, type="SPAN_BOLDANNOUNCE")]</span>"
#define SPAN_BOLDNOTICE(X, args...) "<span class='boldnotice'>[ru_span(X, ##args, type="SPAN_BOLDNOTICE")]</span>"

#define SPAN_NOTICE(X, args...) "<span class='notice'>[ru_span(X, ##args, type="SPAN_NOTICE")]</span>"

#define SPAN_ALERTWARNING(X, args...) "<span class='alertwarning'>[ru_span(X, ##args, type="SPAN_ALERTWARNING")]</span>"
#define SPAN_WARNING(X, args...) "<span class='warning'>[ru_span(X, ##args, type="SPAN_WARNING")]</span>"
#define SPAN_BOLDWARNING(X, args...) "<span class='boldwarning'>[ru_span(X, ##args, type="SPAN_BOLDWARNING")]</span>"
#define SPAN_ALERT(X, args...) "<span class='alert'>[ru_span(X, ##args, type="SPAN_ALERT")]</span>"

#define SPAN_INFO(X, args...) "<span class='info'>[ru_span(X, ##args, type="SPAN_INFO")]</span>"

#define SPAN_DANGER(X, args...) "<span class='danger'>[ru_span(X, ##args, type="SPAN_DANGER")]</span>"
#define SPAN_USERDANGER(X, args...) "<span class='userdanger'>[ru_span(X, ##args, type="SPAN_USERDANGER")]</span>"
#define SPAN_HIGHDANGER(X, args...) "<span class='highdanger'>[ru_span(X, ##args, type="SPAN_HIGHDANGER")]</span>"

#define SPAN_CENTERBOLD(X, args...) "<span class='centerbold'>[ru_span(X, ##args, type="SPAN_CENTERBOLD")]</span>"

#define SPAN_HELPFUL(X, args...) "<span class='helpful'>[ru_span(X, ##args, type="SPAN_HELPFUL")]</span>"

#define SPAN_LOCALSAY(X, args...) "<span class='say'>[ru_span(X, ##args, type="SPAN_LOCALSAY")]</span>"
#define SPAN_DEADSAY(X, args...) "<span class='deadsay'>[ru_span(X, ##args, type="SPAN_DEADSAY")]</span>"

#define SPAN_AVOIDHARM(X, args...) "<span class='avoidharm'>[ru_span(X, ##args, type="SPAN_AVOIDHARM")]</span>"

#define SPAN_SCANNER(X, args...) "<span class='scanner'>[ru_span(X, ##args, type="SPAN_SCANNER")]</span>"

#define SPAN_ROSE(X, args...) "<span class='rose'>[ru_span(X, ##args, type="SPAN_ROSE")]</span>"
#define SPAN_LANGCHAT(X) "<span class='langchat'>[X]</span>"
#define SPAN_MODERATE(X, args...) "<span class='moderate'>[ru_span(X, ##args, type="SPAN_MODERATE")]</span>"
#define SPAN_DISARM(X, args...) "<span class='disarm'>[ru_span(X, ##args, type="SPAN_DISARM")]</span>"
#define SPAN_DL1(X, args...) "<span class='dl1'>[ru_span(X, ##args, type="SPAN_DL1")]</span>"
#define SPAN_NEWSCASTER(X, args...) "<span class='newscaster'>[ru_span(X, ##args, type="SPAN_NEWSCASTER")]</span>"
#define SPAN_ROUND_HEADER(X, args...) "<span class='round header'>[ru_span(X, ##args, type="SPAN_ROUND_HEADER")]</span>"
#define SPAN_EMOTE(X, args...) "<span class='emote'>[ru_span(X, ##args, type="SPAN_EMOTE")]</span>"
#define SPAN_UNCONSCIOUS(X, args...) "<span class='unconscious'>[ru_span(X, ##args, type="SPAN_UNCONSCIOUS")]</span>"
#define SPAN_SUICIDE(X, args...) "<span class='suicide'>[ru_span(X, ##args, type="SPAN_SUICIDE")]</span>"
#define SPAN_SCANNERB(X, args...) "<span class='scannerb'>[ru_span(X, ##args, type="SPAN_SCANNERB")]</span>"

// Colors
#define SPAN_BLUE(X, args...) "<span class='blue'>[ru_span(X, ##args, type="SPAN_BLUE")]</span>"
#define SPAN_GREEN(X, args...) "<span class='green'>[ru_span(X, ##args, type="SPAN_GREEN")]</span>"
#define SPAN_RED(X, args...) "<span class='red'>[ru_span(X, ##args, type="SPAN_RED")]</span>"
#define SPAN_ORANGE(X, args...) "<span class='orange'>[ru_span(X, ##args, type="SPAN_ORANGE")]</span>"
#define SPAN_PURPLE(X, args...) "<span class='purple'>[ru_span(X, ##args, type="SPAN_PURPLE")]</span>"
#define SPAN_MAROON(X, args...) "<font color=Maroon>[ru_span(X, ##args, type="SPAN_MAROON")]</font>"

#define SPAN_STAFF_IC(X, args...) "<span class='staff_ic'>[ru_span(X, ##args, type="SPAN_STAFF_IC")]</span>"
#define SPAN_BIGNOTICE(X, args...) "<span class='bigannounce'>[ru_span(X, ##args, type="SPAN_BIGNOTICE")]</span>"

#define SPAN_TRANSLATE(X, args...) "[ru_span(X, ##args, type="SPAN_TRANSLATE")]"
// SS220 END EDIT ADDICTION
