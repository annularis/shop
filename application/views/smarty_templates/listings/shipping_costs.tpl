        {capture name='t_form_action'}listings/shipping/{$item.hash}{/capture}
        {capture name='t_form_cancel'}listings/edit/{$item.hash}{/capture}
        {capture name='t_alter_form_errors'}{form method="validation_errors"}{/capture}

                <div class="col-lg-9" id="manage_items">
            <div class="row">
                            <h2>Shipping Costs: {$item.name|escape:"html":"UTF-8"}</h2>

                {assign var="defaultMessage" value=""}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {if $shipping_costs == TRUE}
                {form method="open" action=$smarty.capture.t_form_action attr=['class'=>'form-horizontal']}
                    <div class='container'>
                        <div class="card bg-light card-body mb-3 col-xl-8"></div>

                            {if strlen($smarty.capture.t_alter_form_errors) > 0}
                            <div class="alert alert-danger">{$smarty.capture.t_alter_form_errors}</div>
                            {/if}
                            <h4>Review Shipping Costs</h4>
                            <br />

                            <div class='form-group'>
                                <div class='col-3'><label class="control-label col-3" for="title_dest">Destination</label></div>
                                <div class='col-5'><label class="control-label col-5" for="title_cost">Cost</label></div>
                                <div class='col-2'><label class="control-label col-2" for="title_dest">Offered</label></div>
                            </div>
                            {foreach from=$shipping_costs item=cost}
                                {capture name="t_cost_field"}cost[{$cost.id}][cost]{/capture}
                                {capture name="t_enabled_field"}cost[{$cost.id}][enabled]{/capture}
                                <div class="form-group">
                                    <div class="col-12">
                                        <div class='col-3'><label class="control-label col-3" for="add_price">{$cost.destination_f}</label></div>
                                        <div class="col-5">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i>{$item.currency.code}</i></span>
                                                <input type="text" class='form-control' name="{$smarty.capture.t_cost_field}" value="{$cost.cost}" />
                                            </div>
                                        </div>
                                        <div class="col-2"><input type="checkbox" name="{$smarty.capture.t_enabled_field}" value="1" {if $cost.enabled == '1'}checked{/if} /></div>
                                    </div>
                                    <div class="col-9 mx-auto">
                                        {form method="form_error" field=$smarty.capture.t_cost_field}
                                        {form method="form_error" field=$smarty.capture.t_enabled_field}
                                    </div>
                                </div>

                            {/foreach}

                            <div class="form-group">
                                <label class="control-label col-2" for="submit"></label>
                                <div class="col-5">
                                    <p align="center">
                                        <input type='submit' name='update_shipping_cost' value='Update' class='btn btn-primary' />
                                        {url type="anchor" url="listings" text="Cancel" attr='title="Cancel" class="btn btn-default"'}
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                </form>
                {/if}

                {form method="open" action=$smarty.capture.t_form_action attr=['class'=>'form-horizontal']}
                <div class='container'>
                   <div class="card bg-light card-body mb-3 col-xl-8"></div>
                      <h4>New Shipping Cost</h4>
                        <br />

                        <div class="form-group">
                            <label class="control-label col-2" for="add_location">Destination</label>
                            <div class="col-5">
                                {$locations}
                            </div>
                            <span class="help-inline">{form method="form_error" field="add_location"}</span>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-2" for="add_price">Price</label>
                            <div class="col-5">
                                <div class="input-group">
                                    <span class="input-group-addon"><i>{$item.currency.code}</i></span>
                                    <input type='text' name='add_price' class="form-control" id="add_price" value="{if $item.currency.id == '0'}0.003{else}10{/if}" />
                                </div>
                            </div>
                            <span class="help-inline">{form method="form_error" field="add_price"}</span>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-2" for="submit"></label>
                            <div class="col-5">
                                <p align="center">
                                    <input type='submit' name='add_shipping_cost' value='Add' class='btn btn-primary' />
                                    {url type="anchor" url=$smarty.capture.t_form_cancel text="Cancel" attr='class="btn btn-default"'}
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
                </div>
        </div>
