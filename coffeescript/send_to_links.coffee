# Add the "send to" links dropdown at the record level rather than as part of the details tab.
jQuery ($) ->
  scopes = ''
  vid = ''
  tab = ''
  containerCSS = 
    position: 'absolute'
    top: '10px'
    right: '1em'
  liCSS = 
    width: 'auto'
    backgroundColor: 'transparent'
  linksContainerCSS = 
    borderTop: '1px solid #e1e1e1'
    position: 'absolute'
    left: 'auto'
  iconCSS = 
    height: '18px'

  buildLinks = (record, index) ->
    recordID = record.find('.EXLResultRecordId').attr('id')
    if tab
      tabParam = "&amp;tab=#{tab}"
    else
      tabParam = ""
    linksHTML = """
      <div class="EXLTabHeaderButtons ndl-sendto-links">
        <ul>
          <li class="EXLTabHeaderButtonSendTo" style="list-style-type: none;"><a title="show send to options" id="in#{recordID}" name="in#{recordID}" href="#"><span></span>Export/E-mail <img alt="" src="../images/icon_arrow_sendTo.png"></a>
            <ol class="EXLTabHeaderButtonSendToList" style="display: none;">
              <li class="EXLButtonSendToMyShelf EXLButtonSendToMyShelfAdd">
                <a href="#{addSessionId('basket.do')}?fn=create&amp;docs=#{recordID}&amp;exemode=async" title="Add to Folder" target="_blank">
                <span class="EXLButtonSendToLabel">Add to Folder</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconMyShelf"></span>
                </a>
              </li>
              <li class="EXLButtonSendToMyShelf EXLButtonSendToMyShelfRemove" style="display: none;">
                <a href="#{addSessionId('basket.do')}?fn=remove&amp;docs=#{recordID}&amp;exemode=async" title="Remove from Folder" target="_blank">
                <span class="EXLButtonSendToLabel">Remove from Folder</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconMyShelf"></span>
                </a>
              </li>
              <li class="EXLButtonSendToMail">
                <a href="#{addSessionId('email.do')}?fn=email&amp;docs=#{recordID}&amp;vid=#{vid}&amp;fromCommand=true&amp;doc=#{recordID}&amp;scope=#{escape(scopes)}&amp;indx=#{index}&amp;" title="Send record by E-mail(opens in a new window)" target="_blank">
                <span class="EXLButtonSendToLabel">E-mail</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconMail"></span>
                </a>
              </li>
              <li class="EXLButtonSendToPrint">
                <a href="#{addSessionId('display.do')}?fn=print#{tabParam}&amp;indx=#{index}&amp;display=print&amp;docs=#{recordID}&amp;" title="Print record (opens in a new window)" target="_blank">
                <span class="EXLButtonSendToLabel">Print</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconPrint"></span>
                </a>
              </li>
              <li class="EXLButtonSendToPermalink">
                <a href="#{addSessionId('permalink.do')}?docId=#{recordID}&amp;vid=#{vid}&amp;fn=permalink" title="Permanent URL for this record" target="_blank">
                <span class="EXLButtonSendToLabel">Permalink</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconPermalink"></span></a>
              </li>
              <li class="EXLButtonSendToCitation">
                <a href="#" title="Bibliographic citation for this title" target="_blank">
                <span class="EXLButtonSendToLabel">Citation</span>
                <span class="EXLButtonSendToIcon EXLButtonSendToIconCitation"></span>
                </a>
              </li>
              <li class="EXLButtonSendToEndNote">
                <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=EndNote&amp;fromEshelf=false" title="Add to EndNote" target="_blank">
                  <span class="EXLButtonSendToLabel">
                    EndNote</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconEndNote"></span>
                </a>
              </li>
              <li class="EXLButtonSendToRefWorks">
                <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=RefWorks&amp;fromEshelf=false" title="Add to RefWorks" target="_blank">
                  <span class="EXLButtonSendToLabel">
                    RefWorks</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconRefWorks"></span>
                </a>
              </li>
              <li class="EXLButtonSendToDelicious">
                <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=Delicious&amp;fromEshelf=false" title="Add to Delicious" target="blank">
                  <span class="EXLButtonSendToLabel">
                    del.icio.us</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconDelicious"></span>
                </a>
              </li>
              <li class="EXLButtonSendToRIS">
                <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=RISPushTo&amp;fromEshelf=false" title="Add to RISPushTo" target="_blank">
                  <span class="EXLButtonSendToLabel">
                    Export RIS</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconRISPushTo"></span>
                </a>
              </li>
            </ol>
          </li>
        </ul>
      </div>
    """
    container = $(linksHTML)
    container.css(containerCSS)
    container.find('.EXLTabHeaderButtonSendTo').css(liCSS)
    container.find('.EXLTabHeaderButtonSendToList').css(linksContainerCSS)
    container.find('li span').css(iconCSS)
    container.find('.EXLButtonSendToMyShelfAdd a').click (event) ->
      event.preventDefault()
      eshelfCreate(this,recordID,'false',scopes,"#{index}")
    container.find('.EXLButtonSendToMyShelfRemove a').click (event) ->
      event.preventDefault()
      eshelfRemove(this,recordID,'false',scopes,"#{index}")
    container.find('.EXLButtonSendToMail a').click (event) ->
      event.preventDefault()
      sendPrintPopOut(this)
    container.find('.EXLButtonSendToPrint a').click (event) ->
      event.preventDefault()
      sendPrintPopOut(this)
    container.find('.EXLButtonSendToPermalink a').click (event) ->
      event.preventDefault()
      openPermaLinkLbox('permalink',"docId=#{recordID}&amp;vid=#{vid}&amp;fn=permalink","#{index - 1}",recordID)
    container.find('.EXLButtonSendToCitation a').click (event) ->
      event.preventDefault()
      openCitationLbox("#{index - 1}",recordID)
    container.find('.EXLButtonSendToEndNote a').click (event) ->
      event.preventDefault()
      pushto('EndNote',"#{index}",'false',recordID)
    container.find('.EXLButtonSendToRefWorks a').click (event) ->
      event.preventDefault()
      pushto('RefWorks',"#{index}",'false',recordID)
    container.find('.EXLButtonSendToRIS a').click (event) ->
      event.preventDefault()
      pushto('RISPushTo',"#{index}",'false',recordID)

    record.find('.EXLSummaryFields').after(container)

    basketIn = 'off'
    basketIcon = record.find('.EXLMyShelfStar img')
    if basketIcon.length > 0
      if /on[.]png/.test(basketIcon.attr('src'))
        basketIn = 'on'
    else
      if record.find('.EXLButtonSendToMyShelfRemove').is(':visible')
        basketIn = 'on'
    ineshelfInit(recordID, basketIn)

  getCurrentVID = ->
    $vid = $('#vid')
    if $vid.length == 0
      # On the browse pages, the vid field has a different id
      $vid = $('#vid_browse_input')
    $vid.val()

  getCurrentTab = ->
    $('#tab').val()

  getStartIndex = ->
    indexVal = $('#indx').val()
    if indexVal
      parseInt(indexVal)
    else
      1

  ready = ->
    scopes = $('#scopesListContainer').find('input:checked').val()
    vid = getCurrentVID()
    tab = getCurrentTab()
    startIndex = getStartIndex()

    $('.EXLResult').each (index, element) ->
      record = $(this)
      buildLinks(record, index + startIndex)

  $(document).ready(ready)
