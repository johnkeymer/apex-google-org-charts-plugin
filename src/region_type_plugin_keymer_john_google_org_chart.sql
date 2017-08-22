set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.2.00.09'
,p_default_workspace_id=>49100495200644846
,p_default_application_id=>116
,p_default_owner=>'KEYMEJ'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/region_type/keymer_john_google_org_chart
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(68743289782614874)
,p_plugin_type=>'REGION TYPE'
,p_name=>'KEYMER.JOHN.GOOGLE_ORG_CHART'
,p_display_name=>'Google Organization Chart'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function f_render (',
'  p_region              in apex_plugin.t_region,',
'  p_plugin              in apex_plugin.t_plugin,',
'  p_is_printer_friendly in boolean )',
'return apex_plugin.t_region_render_result',
'is',
'  l_region_id  varchar2(50) := nvl(p_region.static_id,''R'' || to_char(p_region.id,''fm99999999999999999999'')) || ''_chart'';',
'  l_data       apex_plugin_util.t_column_value_list2;',
'  l_chart_opts varchar2(500);',
'begin',
'  l_data := apex_plugin_util.get_data2(p_sql_statement  => p_region.source,',
'                                    p_min_columns    => 4,',
'                                    p_max_columns    => 4,',
'                                    p_component_name => p_region.name);',
'  ',
'  if l_data(1).value_list.count = 0 then',
'    htp.p(nvl(p_region.no_data_found_message,''no data found''));',
'    return null;',
'  end if;',
'  ',
'  l_chart_opts := ''{'';',
'  l_chart_opts := l_chart_opts || ''allowCollapse:'' || case when p_region.attribute_01 = ''Y'' then ''true'' else ''false'' end || '', '';',
'  l_chart_opts := l_chart_opts || ''allowHtml:'' || case when p_region.attribute_02 = ''Y'' then ''true'' else ''false'' end;',
'  ',
'  if p_region.attribute_03 is not null then',
'    l_chart_opts := l_chart_opts || '', nodeClass:'''''' ||  p_region.attribute_03 || '''''','';',
'  end if;',
'  ',
'  l_chart_opts := l_chart_opts || '', size:'''''' || lower(p_region.attribute_04) || '''''''';',
'  ',
'  if p_region.attribute_05 is not null then',
'    l_chart_opts := l_chart_opts || '', selectedNodeClass:'''''' ||  p_region.attribute_05 || '''''''';',
'  end if;',
'  ',
'  htp.p(htf.div(cattributes=>''id="''||l_region_id|| ''"'')||''</div>'');',
'',
'  htp.p(',
'    q''[ <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>',
'    <script type="text/javascript">',
'    google.charts.load(''current'', {packages:["orgchart"]});',
'    google.charts.setOnLoadCallback(drawChart);',
'',
'    function drawChart() {',
'    var data = new google.visualization.DataTable();',
'    data.addColumn(''string'', ''Name'');',
'    data.addColumn(''string'', ''Manager'');',
'    data.addColumn(''string'', ''ToolTip'');',
'    ',
'    data.addRows([',
'  ]'');',
'  ',
'  for i in 1 .. l_data(1).value_list.count loop',
'    htp.p(''['' ',
'          || ''{v:'''''' ',
'          || l_data(2).value_list(i).varchar2_value ',
'          || '''''', f:''''''',
'          || case when l_data(1).value_list(i).varchar2_value is not null then ',
'               htf.anchor(curl=>l_data(1).value_list(i).varchar2_value, ctext=>l_data(3).value_list(i).varchar2_value)',
'             else l_data(3).value_list(i).varchar2_value end',
'          || ''''''},''',
'          || '''''''' || l_data(4).value_list(i).varchar2_value || '''''',''',
'          || ''''''''''''',
'          || '']''',
'          || case when i < l_data(1).value_list.count then '','' end',
'    );',
'  end loop;',
'  ',
'  htp.p(',
'    q''[',
'      ]);',
'      ',
'      var chart = new google.visualization.OrgChart(document.getElementById('']'' || l_region_id || q''[''));',
'      chart.draw(data, ]'' || l_chart_opts || q''[});',
'    }',
'    </script>',
'  ]'');',
'  ',
'  return null;',
'end;'))
,p_api_version=>2
,p_render_function=>'f_render'
,p_standard_attributes=>'SOURCE_SQL:NO_DATA_FOUND_MESSAGE'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Render an organization style chart using the Google Charts API. Accepts a SQL statement as the region source with the following mandatory columns.',
'1) Link - A URL to link the node to. Use Null for none. Ensure you prepare the URL if session state protection is enabled.',
'2) Child Key - The key to use for this node. This can be numeric or text.',
'3) Child Display Value - The text to display. You may use HTML if you have chosen this option.',
'4) Parent Key - The key of this nodes parent.'))
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(68745874689718334)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Allow Collapse'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(68746477266720067)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Allow HTML'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(68747047678723759)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Node Class'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>30
,p_max_length=>100
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(68748024507734550)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'Medium'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(68748825569735450)
,p_plugin_attribute_id=>wwv_flow_api.id(68748024507734550)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'Small'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(68749203258736037)
,p_plugin_attribute_id=>wwv_flow_api.id(68748024507734550)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'Medium'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(68749676437736766)
,p_plugin_attribute_id=>wwv_flow_api.id(68748024507734550)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'LArge'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(69049348611980122)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Selected Node Class'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(68743497040614881)
,p_plugin_id=>wwv_flow_api.id(68743289782614874)
,p_name=>'SOURCE_SQL'
,p_sql_min_column_count=>5
,p_sql_max_column_count=>5
,p_depending_on_has_to_exist=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select null link, ''1'' key_value, ''Value'' display_value, '''' parent_key',
'from dual;'))
,p_help_text=>'Enter a SQL Query to return the hierarchy'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
