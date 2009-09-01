MODULE = Eir            PACKAGE = Eir::Filter

Filter *
do_new(const char *classname)
CODE:
    RETVAL = new Filter();
OUTPUT:
    RETVAL

Filter *
Filter::is_command(const char *cmd)
CODE:
    THIS->is_command(cmd);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::source_type(int type)
CODE:
    THIS->source_type(type);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::source_named(const char *src)
CODE:
    THIS->source_named(src);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::from_bot(Bot *b)
CODE:
    THIS->from_bot(b);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::in_private()
CODE:
    THIS->in_private();
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::in_channel(const char *chan)
CODE:
    THIS->in_channel(chan);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::requires_privilege(const char *priv)
CODE:
    THIS->requires_privilege(priv);
    RETVAL = THIS;
OUTPUT:
    RETVAL

Filter *
Filter::or_config()
CODE:
    THIS->or_config();
    RETVAL = THIS;
OUTPUT:
    RETVAL

int
Filter::match(Message *m)


MODULE = Eir            PACKAGE = Eir::Message

Bot *
Message::bot()
CODE:
    RETVAL = THIS->bot;
OUTPUT:
    RETVAL

string
Message::command()
CODE:
    RETVAL = THIS->command;
OUTPUT:
    RETVAL

string
Message::raw()
CODE:
    RETVAL = THIS->raw;
OUTPUT:
    RETVAL

SV *
Message::args()
CODE:
    AV *ret = newAV();
    for (auto it = THIS->args.begin(); it != THIS->args.end(); ++it)
        av_push(ret, newSVpv(it->c_str(), 0));
    RETVAL = newRV_noinc((SV*)ret);
OUTPUT:
    RETVAL

SV *
Message::source()
CODE:
    HV *ret = newHV();
    hv_store(ret, "type", 4, newSViv(THIS->source.type), 0);
    SV *client = newSV(0);
    sv_setref_pv(client, "Eir::Client", THIS->source.client.get());
    hv_store(ret, "client", 6, client, 0);
    hv_store(ret, "name", 4, newSVpv(THIS->source.name.c_str(), 0), 0);
    hv_store(ret, "raw", 3, newSVpv(THIS->source.raw.c_str(), 0), 0);
    hv_store(ret, "destination", 11, newSVpv(THIS->source.destination.c_str(), 0), 0);

    RETVAL = newRV_noinc((SV*)ret);
OUTPUT:
    RETVAL

void
Message::reply(const char *str)
CODE:
    THIS->source.reply(str);


MODULE = Eir            PACKAGE = Eir::Source

int
RawIrc()
CODE:
    RETVAL = sourceinfo::RawIrc;

int
ConfigFile()
CODE:
    RETVAL = sourceinfo::ConfigFile;

int
SystemConsole()
CODE:
    RETVAL = sourceinfo::SystemConsole;

int
Signal()
CODE:
    RETVAL = sourceinfo::Signal;

int
Internal()
CODE:
    RETVAL = sourceinfo::Internal;

int
IrcCommand()
CODE:
    RETVAL = sourceinfo::IrcCommand;

int
Any()
CODE:
    RETVAL = sourceinfo::Any;

