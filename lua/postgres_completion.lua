-- PostgreSQL 16 keywords from src/include/parser/kwlist.h and built-in types.
local keywords = [[
abort absent absolute access action add admin after aggregate all also alter always
analyse analyze and any array as asc asensitive assertion assignment asymmetric at
atomic attach attribute authorization backward before begin between binary both breadth
by cache call called cascade cascaded case cast catalog chain characteristics check
checkpoint class close cluster coalesce collate collation column columns comment
comments commit committed compression concurrently configuration conflict connection
constraint constraints content continue conversion copy cost create cross csv cube
current current_catalog current_date current_role current_schema current_time
current_timestamp current_user cursor cycle data database day deallocate dec declare
default defaults deferrable deferred definer delete delimiter delimiters depends depth
desc detach dictionary disable discard distinct do document domain double drop each else
enable encoding encrypted end enum escape event except exclude excluding exclusive
execute exists explain expression extension external extract false family fetch filter
finalize first following for force foreign format forward freeze from full function
functions generated global grant granted greatest group grouping groups handler having
header hold hour identity if ilike immediate immutable implicit import in include
including increment indent index indexes inherit inherits initially inline inner inout
input insensitive insert instead intersect into invoker is isnull isolation join
json_array json_arrayagg json_object json_objectagg key keys label language large last
lateral leading leakproof least left level like limit listen load local localtime
localtimestamp location lock locked logged mapping match matched materialized maxvalue
merge method minute minvalue mode month move names national natural nchar new next nfc
nfd nfkc nfkd no none normalize normalized not nothing notify notnull nowait null nullif
nulls object of off offset oids old on only operator option options or order ordinality
others out outer over overlaps overlay overriding owned owner parallel parameter parser
partial partition passing password placing plans policy position preceding precision
prepare prepared preserve primary prior privileges procedural procedure procedures
program publication quote range read reassign recheck recursive ref references
referencing refresh reindex relative release rename repeatable replace replica reset
restart restrict return returning returns revoke right role rollback rollup routine
routines row rows rule savepoint scalar schema schemas scroll search second security
select sequence sequences serializable server session session_user set setof sets share
show similar simple skip snapshot some sql stable standalone start statement statistics
stdin stdout storage stored strict strip subscription substring support symmetric sysid
system system_user table tables tablesample tablespace temp template temporary then ties
to trailing transaction transform treat trigger trim true truncate trusted type types
uescape unbounded uncommitted unencrypted union unique unknown unlisten unlogged until
update user using vacuum valid validate validator value values variadic varying verbose
version view views volatile when where whitespace window with within without work
wrapper write xmlattributes xmlconcat xmlelement xmlexists xmlforest xmlnamespaces
xmlparse xmlpi xmlroot xmlserialize xmltable year yes zone
]]

local types = [[
bigint bigserial bit bool boolean box bpchar bytea char character cidr circle date
datemultirange daterange decimal float float4 float8 inet int int2 int4 int4multirange
int4range int8 int8multirange int8range integer interval json jsonb jsonpath line lseg
macaddr macaddr8 money name numeric nummultirange numrange oid path pg_lsn pg_snapshot
point polygon real regclass regcollation regconfig regdictionary regnamespace regoper
regoperator regproc regprocedure regrole regtype serial serial2 serial4 serial8 smallint
smallserial text tid time timestamp timestamptz timetz tsmultirange tsquery tsrange
tstzmultirange tstzrange tsvector txid_snapshot uuid varbit varchar xid xid8 xml
]]

local multiword_types = {
  "bit varying",
  "character varying",
  "double precision",
  "time with time zone",
  "time without time zone",
  "timestamp with time zone",
  "timestamp without time zone",
}

local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:get_completions(_, callback)
  local kinds = vim.lsp.protocol.CompletionItemKind
  local items = {}
  for word in keywords:gmatch "%S+" do
    items[#items + 1] = { label = word, kind = kinds.Keyword }
  end
  for name in types:gmatch "%S+" do
    items[#items + 1] = { label = name, kind = kinds.TypeParameter }
  end
  for _, name in ipairs(multiword_types) do
    items[#items + 1] = { label = name, kind = kinds.TypeParameter }
  end
  callback { items = items, is_incomplete_forward = false, is_incomplete_backward = false }
end

return source
