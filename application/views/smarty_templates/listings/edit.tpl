            {capture name='t_form_action'}listings/edit/{$item.hash}{/capture}
            {capture name='t_shipping_url'}listings/shipping/{$item.hash}{/capture}

            <div class="col-lg-9" id="manage_items">
                <h2>Edit Item</h2>
                {assign var="defaultMessage" value=""}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {form method="open" action=$smarty.capture.t_form_action attr=['class'=>'form-horizontal']}
                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="name">Name</label>
                            <div class="col-5">
                                <input type='text' name='name' id="name" class='form-control' value="{$item.name|escape:"html":"UTF-8"}" />
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="name"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="description">Description</label>
                            <div class="col-5">
                                <textarea name='description' id="description" class='form-control' rows='6'>{$item.description|escape:"html":"UTF-8"}</textarea>
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="description"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="category">Category</label>
                            <div class="col-5">
                                {$categories}
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="category"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="price">Price</label>
                            <div class="col-5">
                                <div class="input-group">
                                    <span class="input-group-addon"><i>{$item.currency.code}</i></span>
                                    <input type='text' class="form-control" name='price' value="{$item.price|escape:"html":"UTF-8"}" />
                                </div>
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="price"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="currency">Currency</label>
                            <div class="col-5">
                                <select name='currency' id="currency" class='form-control' autocomplete="off">
                                {foreach from=$currencies item=currency}
                                    <option value="{$currency.id}" {if $item.currency.id == $currency.id}selected="selected" {/if}>{$currency.name} ({$currency.symbol})</option>
                                {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="currency"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-2" for="ship_from">Ship From</label>
                            <div class="col-5">
                                {$item_location_select}
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="ship_from"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-4" for="shipping_costs">Shipping Costs</label>
                            <div class="col-5">
                                <label class='help-inline'>{url type="anchor" url=$smarty.capture.t_shipping_url text="Configure" attr='class="btn"'}</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-4" for="hidden">Invisible Listing</label>
                            <div class="col-5">
                                <select name="hidden" id="hidden" class="form-control" autocomplete="off">
                                    <option value=''></option>
                                    <option value='0' {if $item.hidden == '0'}selected="selected" {/if}>No</option>
                                    <option value='1' {if $item.hidden == '1'}selected="selected" {/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="hidden"}</div>
                    </div>

                    <div class="form-group">
                        <div class="col-14">
                            <label class="control-label col-4" for="prefer_upfront">Prefer up-front payment?</label>
                            <div class="col-5">
                                <select name="prefer_upfront" id="prefer_upfront" class="form-control" autocomplete="off">
                                    <option value=""></option>
                                    <option value="0" {if $item.prefer_upfront == '0'}selected="selected" {/if}>No</option>
                                    <option value="1" {if $item.prefer_upfront == '1'}selected="selected" {/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-12 mx-auto">{form method="form_error" field="prefer_upfront"}</div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2 col-xl-2 col-lg-2" for="submit"></label>
                        <div class="col-md-5 col-xl-5 col-lg-5">
                            <p align="center">
                                <input type="submit" value="Update" class="btn btn-primary" />
                                {url type="anchor" url="listings" text="Cancel" attr='class="btn btn-danger"'}
                            </p>
                        </div>
                    </div>
                </form>
            </div>
