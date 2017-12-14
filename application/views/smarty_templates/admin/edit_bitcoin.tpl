            <div class="col-lg-9" id="edit-bitcoin">

                {$nav}

                {assign var="defaultMessage" value=""}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {form method="open" action="admin/edit/bitcoin" attr='class="form-horizontal"'}

                    <div class="form-group">
                        <div class="col-12">
                            <label class="control-label col-4" for="price_index">Use A {$coin.name} Price Index?</label>
                            <div class="col-7">
                                <select name='price_index' class="form-control" autocomplete="off">
                                    {foreach from=$config.price_index_config key=key item=index_config}
                                        <option value='{$key}' {if $key == $config['price_index']}selected="selected"{/if}>{$key|escape:"html":"UTF-8"}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class='col-8 mx-auto'>{form method="form_error" field="price_index"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-12">
                            <label class="control-label col-4" for="bip32_mpk">BIP32 Extended Key</label>
                            <div class="col-7">
                                <input type='text' name='bip32_mpk' class="form-control" value='{$config.bip32_mpk|escape:"html":"UTF-8"}' />
                            </div>
                        </div>
                        <div class='col-8 mx-auto'>{form method="form_error" field="bip32_mpk"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-12">
                            <label class="control-label col-4" for="bip32_iteration">Address Index</label>
                            <div class="col-7">
                                <input type='text' name='bip32_iteration' class="form-control" value="{$config.bip32_iteration|escape:"html":"UTF-8"}" />
                            </div>
                        </div>
                        <div class='col-8 mx-auto'>{form method="form_error" field="bip32_iteration"}</div>
                        <div class="col-10 mx-auto">Only change this if you know what you're doing!</div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-2" for="submit"></label>
                        <div class="col-5">
                            <p align="center">
                                <input type='submit' name='submit_edit_bitcoin' value='Update' class='btn btn-primary' />
                                {url type="anchor" url="admin/bitcoin" text="Cancel" attr='class="btn btn-default"'}
                            </p>
                        </div>
                    </div>
                </form>
            </div>
