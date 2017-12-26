            <div class="col-lg-9" id="admin_edit_items">

                {$nav}

                {assign var="defaultMessage" value=""}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {if $jobs == FALSE}
                <p>There are no autorun jobs. These are stored in ./application/libraries/Autorun. Either
                    this folder is empty or you have not configured your cron daemon to trigger
                    the jobs. Add this following line to your users crontab to activate the jobs:</p>
                <pre>{$autorun_cmd}</pre>
                {else}

                <p>Jobs can be added to the Autorun system by placing them in ./application/libraries/Autorun. From there, you can choose to change the frequency or disable it altogether. To disable a job, check the box beside it and click Update.</p>

                {form method="open" action="admin/autorun" attr='class="form-horizontal"'}
                    {form method="validation_errors"}
                    {foreach from=$jobs key=index item=job}
                        {capture name="t_jobs_interval_field"}jobs[{$index}]{/capture}

                        {if $index == 'price_index' && $config.price_index == 'Disabled'}
                        {else}
                            <div class="panel panel-{if $job.interval == '0'}warning{else}success{/if}">
                                <div class="panel-heading">
                                    <span class="{if $job.interval == '0'}fas fa-times{else}fas fa-check{/if}"></span>
                                    {$job.name|escape:"html":"UTF-8"}
                                    <div class="pull-right">Last Run: {strtolower($job.time_f)}</div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-12 mx-auto"><i>{$job.description|escape:"html":"UTF-8"}</i></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-7">
                                            <div class="col-14 mx-auto">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i>Run every</i></span>
                                                    <input type="text" name="{$smarty.capture.t_jobs_interval_field}" class="form-control" value="{$job.interval|escape:"html":"UTF-8"}" />
                                                    <span class="input-group-addon"><i>{$job.interval_type|escape:"html":"UTF-8"}</i></span>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="checkbox-inline">
                                                    <input type='checkbox' name='disabled_jobs[{$index}]' value='1' {if $job.interval == '0'}checked {/if}/> Disabled
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    {/foreach}

                    <div class="form-group">
                        <div class="col-12">
                            <label class="control-label col-2" for="submit"></label>
                            <div class="col-5">
                                <p align="center">
                                    <input type='submit' value='Update' class='btn btn-primary' />
                                    {url type="anchor" url="admin/autorun" text="Cancel" attr='class="btn btn-danger"'}
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
                {/if}
            </div>
