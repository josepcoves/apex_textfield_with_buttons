set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.2.00.07'
,p_default_workspace_id=>13707805413010735447
,p_default_application_id=>52892
,p_default_owner=>'JOSEPCOVES'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/item_type/es_relational_josepcoves_textfiledicon
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(13895177690862016893)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'ES.RELATIONAL.JOSEPCOVES.TEXTFILEDICON'
,p_display_name=>'Relational: Textfiled with buttons'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  function render_item (',
'    p_item                in apex_plugin.t_page_item,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_value               in varchar2,    ',
'    p_is_readonly         in boolean,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_page_item_render_result ',
'   AS  ',
'   ',
'    v_result apex_plugin.t_page_item_render_result; ',
'    v_page_item_name varchar2(100);',
'    ',
'    v_html varchar2(9000);',
'    ',
'    p_submit_request  p_item.attribute_04%type:= p_item.attribute_04;',
'    p_num_botons  p_item.attribute_08%type:= p_item.attribute_08;',
'    ',
'    p_boto_icona   p_item.attribute_01%type:= p_item.attribute_01;',
'    p_boto_url     p_item.attribute_02%type:= p_item.attribute_02; ',
'    p_boto_css_attrib  p_item.attribute_03%type:= p_item.attribute_03;    ',
'    p_boto_text  p_item.attribute_05%type:= p_item.attribute_05;',
'    p_boto_title  p_item.attribute_06%type:= p_item.attribute_06;',
'    p_boto_attrib  p_item.attribute_07%type:= p_item.attribute_07;',
'    ',
'    p_boto2_icona   p_item.attribute_09%type:= p_item.attribute_09;',
'    p_boto2_url     p_item.attribute_10%type:= p_item.attribute_10; ',
'    p_boto2_css_attrib  p_item.attribute_11%type:= p_item.attribute_11;    ',
'    p_boto2_text  p_item.attribute_12%type:= p_item.attribute_12;',
'    p_boto2_title  p_item.attribute_13%type:= p_item.attribute_13;',
'    p_boto2_attrib  p_item.attribute_14%type:= p_item.attribute_14;',
'    ',
'    ',
'    v_accio_boto varchar2(9000);',
'    v_accio_boto2 varchar2(9000);',
'    ',
'    v_item_attrib varchar2(9000);',
'  BEGIN',
'    ',
'    IF apex_application.g_debug THEN',
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,',
'                                        p_page_item             => p_item,',
'                                        p_value                 => p_value,',
'                                        p_is_readonly           => p_is_readonly,',
'                                        p_is_printer_friendly   => p_is_printer_friendly);',
'    END IF;',
'    ',
'    ',
'    IF p_is_readonly OR p_is_printer_friendly THEN    ',
'      apex_plugin_util.print_hidden_if_readonly (p_item_name             => p_item.name,',
'                                                 p_value                 => p_value,',
'                                                 p_is_readonly           => p_is_readonly,',
'                                                 p_is_printer_friendly   => p_is_printer_friendly);',
'      apex_plugin_util.print_display_only (p_item_name          => p_item.NAME,',
'                                           p_display_value      => p_value,',
'                                           p_show_line_breaks   => FALSE,',
'                                           p_escape             => TRUE,',
'                                           p_attributes         => p_item.element_attributes);',
'    ELSE',
'      ',
'      /********* Retreiving parameters and attributes **********/',
'      v_page_item_name := apex_plugin.get_input_name_for_page_item (p_is_multi_value => FALSE);',
'      ',
'',
'                           ',
'      --Afegim l''event de submit on enter amb el request del mateix nom que l''item',
'      if (p_submit_request is not null) then',
'        v_item_attrib :=p_item.element_attributes||'' onkeypress="return apex.submit({request:''''''||nvl(p_submit_request,p_item.name)||'''''',submitIfEnter:event})" '';',
'      else ',
'        v_item_attrib := p_item.element_attributes;',
'      end if;',
'      ',
'      htp.p(',
'              ''<input type="text" ',
'                      name="''||v_page_item_name||''" ',
'                      id="''||p_item.name||''" ',
'                      class="text_field" ',
'                      value="''||p_value||''" ',
'                      size="''||p_item.element_width||''" ',
'                      maxlength="''||p_item.element_max_length||''" ''||',
'                      v_item_attrib||'' >''',
'          ',
'            );                            ',
'      ',
'      if (p_num_botons >= 1) then',
'        if (p_boto_url is null) then ',
'          --v_accio_boto := ''javascript:apex.submit({request:''''''||nvl(p_submit_request,p_item.name)||'''''',set:{''||p_item.name||'':$(''''#''||p_item.name||'''''').val()}});'';',
'          v_accio_boto := ''javascript:apex.submit({request:''''''||nvl(p_submit_request,p_item.name)||''''''});'';',
'        end if;',
'        /**** Primer botó */',
'        htp.p(''<span>             ',
'                 <button class="t-Button t-Button--icon t-Button--iconRight t-Button--small ''||p_boto_css_attrib||''" onclick="''||v_accio_boto||''" type="button" title="''||p_boto_title||''" ''||p_boto_attrib||''>',
'                   <span class="t-Icon t-Icon--left fa ''||p_boto_icona||''" aria-hidden="true"></span>'');',
'        if (p_boto_text is not null) then                 ',
'          htp.p(''',
'                   <span class="t-Button-label">''||p_boto_text||''</span>'');',
'        end if;',
'        htp.p(''',
'                   <span class="t-Icon t-Icon--right fa ''||p_boto_icona||''" aria-hidden="true"></span>',
'                 </button>'');',
'                 ',
'        /**** Segon botó ***/                 ',
'        if (p_num_botons >= 2) then',
'          if (p_boto2_url is null) then ',
'            v_accio_boto2 := v_accio_boto;',
'          end if;',
'          htp.p(''',
'                <button class="t-Button t-Button--icon t-Button--iconRight t-Button--small ''||p_boto2_css_attrib||''" onclick="''||v_accio_boto2||''" type="button" title="''||p_boto2_title||''" ''||p_boto2_attrib||''>',
'                   <span class="t-Icon t-Icon--left fa ''||p_boto2_icona||''" aria-hidden="true"></span>'');',
'          if (p_boto2_text is not null) then                 ',
'            htp.p(''',
'                   <span class="t-Button-label">''||p_boto2_text||''</span>'');',
'          end if;',
'          htp.p(''',
'                   <span class="t-Icon t-Icon--right fa ''||p_boto2_icona||''" aria-hidden="true"></span>',
'                 </button>'');                     ',
'        end if;',
'        htp.p(''</span>'');',
'       end if;',
'            ',
' ',
'      /****** JAVASCRIPT **************/      ',
'      ',
'      ',
'       --Afegim el placeholder en cas que estigui definit',
'       if (p_item.placeholder is not null) then',
'         v_html := v_html||''$(''''#''||p_item.name||'''''').attr(''''placeholder'''',''''''||nvl(p_item.placeholder,'''')||'''''');'';',
'       end if;',
'       apex_javascript.add_onload_code (p_code => v_html);',
'       ',
'    END IF; ',
'    RETURN v_result;',
'  end render_item;',
'  ',
'  ',
'  ',
'  '))
,p_render_function=>'render_item'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:SESSION_STATE:READONLY:QUICKPICK:SOURCE:FORMAT_MASK_DATE:ELEMENT:WIDTH:PLACEHOLDER:ENCRYPT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<b>',
'  <h1>RELATIONAL: Textfield with buttons </h1>',
'  <p>RELATIONAL </p>',
'  <p>Josep Coves - josepcoves@relational.es</p>',
'  <p>Creation Date: September - 2015</p>',
'  <br>',
'  <br>',
'  <h2><i>History review:</i></h2>',
'</b><br>',
'<br>',
'<p>APEX item which creates a single item with one or two buttons on the right.</p>',
'<p>Features</p>',
'<ul>',
'  <li>Submit on enter -> Submits page with request name = NAME_OF_ITEM</li>',
'</ul',
'<p><i>',
'Additional info:<br>',
'</p></i></br>'))
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895180762425128343)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Button 1: CSS Icon (FA)'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_default_value=>'fa-search'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
,p_examples=>'fa-search'
,p_help_text=>'Font awesome Icon (only if using Universal Theme)'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895182516417304919)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Button 1: Url'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
,p_help_text=>'URL which will use button, if null uses item name as request.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895183222765323443)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Button 1: CSS Attributes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
,p_examples=>'t-Button--hot'
,p_help_text=>'CSS attributes'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895184935288917816)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>2
,p_prompt=>'Submit on-enter request'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Request submitted on enter. If blank doesn''t associate submit on enter key event'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895185572500935877)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Button 1: Text'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
,p_help_text=>'Text name of button'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895186220318938162)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Button 1: Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
,p_help_text=>'Title'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895186798392939606)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Button 1: Attributes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'1,2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895210130881113600)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>5
,p_prompt=>'Number of buttons'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'1'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(13895217868359130089)
,p_plugin_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_display_sequence=>10
,p_display_value=>'No buttons'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(13895210683368114300)
,p_plugin_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_display_sequence=>15
,p_display_value=>'1 button'
,p_return_value=>'1'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(13895211047749114630)
,p_plugin_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_display_sequence=>20
,p_display_value=>'2 buttons'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895191557265056856)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Button 2: CSS Icon (FA)'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895193153208066776)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Button 2: Url'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895194270105069241)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Button 2: CSS attributes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895195340105072243)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Button 2: Text'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895196506301073748)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Button 2: Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(13895197610795075447)
,p_plugin_id=>wwv_flow_api.id(13895177690862016893)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Button 2: Attributes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(13895210130881113600)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2'
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
